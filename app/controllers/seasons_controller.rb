class SeasonsController < ActionController::API
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
    render json: {message: "No TV Series with that ID found", error: record_missing_exception, status: 404}
  end

  before_action :check_clean_params, only: [:addSeason]

  def addSeason
    @series = TvShow.find(params[:series_id])
    @season = @series.seasons.new(season_params)
    if @season.save
      render json: {response: "Season saved!"}
    else
      render json: {response: "Season failed to save"}
    end
  end

  private

  def season_params
      params.require(:season).require([:name, :description, :releaseDate])
      Date.parse(params[:season][:releaseDate])
      params.require(:season).permit(:name, :description, :releaseDate)
  end

  def check_clean_params
    unless params[:season] &&
          params[:season][:name] &&
          params[:season][:description] &&
          params[:season][:releaseDate]

      render json: {response: "You're missing required parameters"}
    end
  end

end
