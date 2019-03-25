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

  rescue_from(ActiveRecord::RecordNotFound) do |record_missing_exception|
    render json: {message: "No feature with that ID found", error: record_missing_exception, status: 404}, status: 404
  end

  before_action :check_clean_params, only: [:addShow, :updateShow]

  def allShows
    @series = TvShow.all
    render json: { response: @series }
  end

  def getShow
    @series = TvShow.find(params[:series_id])
    @seasons = populateSeasons(@series.seasons)
    render json: { response: {series: @series, seasons: @seasons, } }
  end

  def addShow
    @series = TvShow.new(series_params)
    if @series.save
      render json: {response: "TV Series saved!"}
    else
      render json: {response: "TV Series failed to save"}
    end
  end

  def deleteShow
    @series = TvShow.find(params[:series_id])
    @series.destroy!
    render json: { response: "TV Series successfully deleted" }
  end

  def updateShow
    @series = TvShow.find(params[:series_id])
    if @series.update_attributes(series_params)
      render json: { response: "TV Series successfully updated" }
		else
      render json: { response: "Failed to update TV Series" }
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

  def populateSeasons(seasons)
    populated = []
    seasons.each { |season|
      @episodes = season.episodes
      populated_season = season.as_json
      populated_season[:episodes] = @episodes
      populated << populated_season
    }
    return populated
  end

  def check_clean_params
    unless params[:series] &&
          params[:series][:name].present? &&
          params[:series][:description].present? &&
          params[:series][:releaseDate].present?

      render json: {message: "You're missing required parameters", status: 400}, status: 400
    end
  end

end
