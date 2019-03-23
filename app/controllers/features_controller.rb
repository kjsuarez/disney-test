class FeaturesController < ActionController::API
  require 'date'

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error = {}
    error[parameter_missing_exception.param] = ['parameter is required']
    render json: {errors: [error], status: :unprocessable_entity}
  end

  def addFeature
    @feature = Feature.new(feature_params)
    if @feature.save
      render json: {response: "feature saved!"}
    else
      render json: {response: "feature failed to save"}
    end
  end

  private

  def paramsClean()
    # begin
    #   Date.parse(params[:feature][:theatricalReleaseDate])
    # rescue ArgumentError
    #   return false
    # end
    return true
  end

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


end
