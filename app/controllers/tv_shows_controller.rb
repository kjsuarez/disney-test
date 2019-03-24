class TvShowsController < ActionController::API
  require 'date'

  rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
    error = {}
    error[parameter_missing_exception.param] = ['parameter is required']
    render json: {errors: [error], status: :unprocessable_entity}
  end

  rescue_from(ArgumentError) do |parameter_missing_exception|
    render json: {message: "bad date syntax", error: parameter_missing_exception, status: 402}
  end

  def addShow
    @series = TvShow.new(series_params)
    if @series.save
      render json: {response: "TV Series saved!"}
    else
      render json: {response: "TV Series failed to save"}
    end
  end

  private

  def series_params
    begin      
      Date.parse(params[:series][:releaseDate])
      params.require(:series).require([:name, :description, :releaseDate])
      params.require(:series).permit(:name, :description, :releaseDate)
    rescue ActionController::ParameterMissing => e
      return e
    rescue ArgumentError => e
      return e
    end
  end


end
