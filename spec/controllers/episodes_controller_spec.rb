require 'spec_helper'

describe EpisodesController do

  describe "GET #getEpisode" do
    before(:each) do
      @series = FactoryGirl.create :series_with_season
      @season = @series.seasons.first
      @episode = @season.episodes.first
      get :getEpisode, params: { episode_id: @episode.id }, format: :json
    end

    it "returns the feature" do
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:response][:episode][:name]).to eql @episode.name
    end

    it "passes with a legal id" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET #getEpisode with bad id" do
    before(:each) do
      @series = FactoryGirl.create :series_with_season
      @season = @series.seasons.first
      @episode = @season.episodes.first
      get :getEpisode, params: { episode_id: 1000 }, format: :json
    end

    it "returns gracefull error" do
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:error]).to eql "Couldn't find Episode with 'id'=1000"
    end

    it "failed gracefully with a bad id" do
      expect(response.status).to eq(404)
    end
  end

  describe "POST #addEpisode" do

    context "when is successfully created" do
      before(:each) do
        @series = FactoryGirl.create :series_with_season
        @season = @series.seasons.first
        @episode_attributes = FactoryGirl.attributes_for :episode
        post :addEpisode, params: { episode: @episode_attributes, season_id: @season.id }, format: :json
      end

      it "succeeds when" do
        episode_response = JSON.parse(response.body, symbolize_names: true)
        expect(episode_response[:response]).to eql "Episode saved!"
      end

      it "passes with a legal id" do
        expect(response.status).to eq(200)
      end
    end

    context "fails when" do
      before(:each) do
        @invalid_episode_attributes = {"description": "floop", "duration": 30000}
      end


      it "needs all params to be present" do
        @series = FactoryGirl.create :series_with_season
        @season = @series.seasons.first
        @invalid_episode_attributes[:name] = ""
        post :addEpisode, params: { episode: @invalid_episode_attributes, season_id: @season.id }, format: :json
        episode_response = JSON.parse(response.body, symbolize_names: true)
        expect(episode_response[:status]).to eql 400
      end

    end
  end

  describe "PUT #updateEpisode" do
    context "when is successfully created" do
      before(:each) do
        @series = FactoryGirl.create :series_with_season
        @season = @series.seasons.first
        @episode = @season.episodes.first
        @episode_attributes = FactoryGirl.attributes_for :episode
        put :updateEpisode, params: { episode: @episode_attributes, episode_id: @episode.id}, format: :json
      end

      it "succeeds when" do
        episode_response = JSON.parse(response.body, symbolize_names: true)
        expect(episode_response[:response]).to eql "Episode successfully updated"
      end

      it "passes with a legal id" do
        expect(response.status).to eq(200)
      end
    end
  end

end
