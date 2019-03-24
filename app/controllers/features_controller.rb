class FeaturesController < ActionController::API
  require 'date'

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error = {}
    error[parameter_missing_exception.param] = ['parameter is required']
    render json: {errors: [error], status: :unprocessable_entity}
  end

  rescue_from(ArgumentError) do |parameter_missing_exception|
    render json: {message: "bad date syntax", error: parameter_missing_exception, status: 402}, status: 402
  end

  rescue_from(ActiveRecord::RecordNotFound) do |record_missing_exception|
    render json: {message: "No feature with that ID found", error: record_missing_exception, status: 404}, status: 404
  end

  before_action :check_clean_params, only: [:addFeature]

  def addFeature
    @feature = Feature.new(feature_params)
    if @feature.save
      render json: {response: "feature saved!"}
    else
      render json: {response: "feature failed to save"}
    end
  end

  def allFeatures
    @features = Feature.all
    render json: { response: @features }
  end

  def getFeature
    @feature = Feature.find(params[:feature_id])
    @bonuses = @feature.bonus_features
    render json: { response: {feature: @feature, bonuses: @bonuses} }
  end

  private

  def feature_params
    begin
      Date.parse(params[:feature][:theatricalReleaseDate])
      params.require(:feature).require([:name, :description, :theatricalReleaseDate, :duration])
      params.require(:feature).permit(:name, :description, :theatricalReleaseDate, :duration)
    rescue ActionController::ParameterMissing => e
      return e
    rescue ArgumentError => e
      return e # render json: {error: "insufficient metadata to create a feature"}
    end
  end

  def check_clean_params
    unless params[:feature] &&
          params[:feature][:name].present? &&
          params[:feature][:description].present? &&
          params[:feature][:theatricalReleaseDate].present? &&
          params[:feature][:duration].present?

      render json: {message: "You're missing required parameters", status: 400}, status: 400
    end
  end


end
