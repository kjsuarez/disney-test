class EpisodesController < ActionController::API
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
    render json: {message: "No TV Series with that ID found", error: record_missing_exception, status: 404}, status: 404
  end

  before_action :check_clean_params, only: [:addEpisode, :updateEpisode]

  def allEpisodes
    @episodes = Episode.all
    render json: { response: @episodes }
  end

  def getEpisode
    @episode = Episode.find(params[:episode_id])
    @season = @episode.season
    @series = @season.tv_show
    render json: { response: {episode: @episode, season: @season, series: @series} }
  end

  def addEpisode
    @season = Season.find(params[:season_id])
    @episode = @season.episodes.new(episode_params)
    if @episode.save
      render json: {response: "Episode saved!"}
    else
      render json: {response: "Episode failed to save"}
    end
  end

  def deleteEpisode
    @episode = Episode.find(params[:episode_id])
    @episode.destroy!
    render json: { response: "Episode successfully deleted" }
  end

  def updateEpisode
    @episode = Episode.find(params[:episode_id])
    if @episode.update_attributes(episode_params)
      render json: { response: "Episode successfully updated" }
		else
      render json: { response: "Failed to update Episode" }
		end
  end

  private

  def episode_params
      params.require(:episode).require([:name, :description, :releaseDate, :duration])
      Date.parse(params[:episode][:releaseDate])
      params.require(:episode).permit(:name, :description, :releaseDate, :duration)
  end

  def check_clean_params
    unless params[:episode] &&
          params[:episode][:name].present? &&
          params[:episode][:description].present? &&
          params[:episode][:releaseDate].present? &&
          params[:episode][:duration].present?

      render json: {message: "You're missing required parameters", status: 400}, status: 400
    end
  end

end
