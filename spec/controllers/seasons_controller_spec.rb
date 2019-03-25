require 'spec_helper'

describe SeasonsController do

  describe "GET #getSeason" do
    before(:each) do
      @series = FactoryGirl.create :series_with_season
      @season = @series.seasons.first
      @episode = @season.episodes.first
      get :getSeason, params: { season_id: @season.id }, format: :json
    end

    it "returns the feature" do
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:response][:season][:name]).to eql @season.name
    end

    it "passes with a legal id" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET #getSeason with bad id" do
    before(:each) do
      @series = FactoryGirl.create :series_with_season
      @season = @series.seasons.first
      @episode = @season.episodes.first
      get :getSeason, params: { season_id: 1000 }, format: :json
    end

    it "returns gracefull error" do
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:error]).to eql "Couldn't find Season with 'id'=1000"
    end

    it "failed gracefully with a bad id" do
      expect(response.status).to eq(404)
    end
  end

  describe "POST #addSeason" do

    context "when is successfully created" do
      before(:each) do
        @series = FactoryGirl.create :series_with_season
        @season_attributes = FactoryGirl.attributes_for :season
        post :addSeason, params: { season: @season_attributes, series_id: @series.id }, format: :json
      end

      it "succeeds when" do
        season_response = JSON.parse(response.body, symbolize_names: true)
        expect(season_response[:response]).to eql "Season saved!"
      end

      it "passes with a legal id" do
        expect(response.status).to eq(200)
      end
    end

    context "fails when" do
      before(:each) do
        @invalid_season_attributes = {"description": "floop", "duration": 30000}
      end


      it "needs all params to be present" do
        @series = FactoryGirl.create :series_with_season
        @invalid_season_attributes[:name] = ""
        post :addSeason, params: { season: @invalid_season_attributes, series_id: @series.id }, format: :json
        season_response = JSON.parse(response.body, symbolize_names: true)
        expect(season_response[:status]).to eql 400
      end

    end
  end

  describe "PUT #updateSeason" do
    context "when is successfully created" do
      before(:each) do
        @series = FactoryGirl.create :series_with_season
        @season = @series.seasons.first
        @season_attributes = FactoryGirl.attributes_for :season
        put :updateSeason, params: { season: @season_attributes, season_id: @season.id}, format: :json
      end

      it "succeeds when" do
        season_response = JSON.parse(response.body, symbolize_names: true)
        expect(season_response[:response]).to eql "Season successfully updated"
      end

      it "passes with a legal id" do
        expect(response.status).to eq(200)
      end
    end
  end

end
