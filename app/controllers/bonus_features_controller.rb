class BonusFeaturesController < ActionController::API
  require 'date'

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error = {}
    error[parameter_missing_exception.param] = ['parameter is required']
    render json: {errors: [error], status: :unprocessable_entity}
  end

  rescue_from(ArgumentError) do |parameter_missing_exception|
    render json: {message: "bad date syntax", error: parameter_missing_exception, status: 402}
  end

  rescue_from(ActiveRecord::RecordNotFound) do |record_missing_exception|
    render json: {message: "No feature with that ID found", error: record_missing_exception, status: 404}
  end

  def allBonuses
    @bonuses = BonusFeature.all
    render json: {response: @bonuses}
  end

  def addBonus
    @feature = Feature.find(params[:feature_id])
    @bonus = @feature.bonus_features.new(bonus_params)
    if @bonus.save
      render json: {response: "Bonus saved!"}
    else
      render json: {response: "Bonus failed to save"}
    end
  end

  private

  def bonus_params
    begin
      params.require(:bonus).require([:name, :description, :duration])
      params.require(:bonus).permit(:name, :description, :duration)
    rescue ActionController::ParameterMissing => e
      return e
    rescue ArgumentError => e
      return e
    end
  end


end
