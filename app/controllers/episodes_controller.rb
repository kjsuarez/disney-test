class EpisodesController < ActionController::API
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

  before_action :check_clean_params, only: [:addEpisode]

  def allEpisodes
    @episodes = Episode.all
    render json: { response: @episodes }
  end

  def getEpisode
    @episode = TvShow.find(params[:episode_id])    
    render json: { response: @episode }
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

  private

  def episode_params
      params.require(:episode).require([:name, :description, :releaseDate, :duration])
      Date.parse(params[:episode][:releaseDate])
      params.require(:episode).permit(:name, :description, :releaseDate, :duration)
  end

  def check_clean_params
    unless params[:episode] &&
          params[:episode][:name] &&
          params[:episode][:description] &&
          params[:episode][:releaseDate] &&
          params[:episode][:duration]

      render json: {response: "You're missing required parameters"}
    end
  end

end
