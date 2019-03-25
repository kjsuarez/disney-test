require 'spec_helper'
describe TvShowsController do

  describe "GET #getShow" do
    before(:each) do
      @series = FactoryGirl.create :series_with_season
      @season = @series.seasons.first
      get :getShow, params: { series_id: @series.id }, format: :json
    end

    it "returns the feature" do
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:response][:series][:name]).to eql @series.name
    end

    it "passes with a legal id" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET #getShow with bad id" do
    before(:each) do
      @series = FactoryGirl.create :series_with_season
      @season = @series.seasons.first
      get :getShow, params: { series_id: 1000 }, format: :json
    end

    it "returns gracefull error" do
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:error]).to eql "Couldn't find TvShow with 'id'=1000"
    end

    it "failed gracefully with a bad id" do
      expect(response.status).to eq(404)
    end
  end

  describe "POST #addShow" do

    context "when is successfully created" do
      before(:each) do
        @series_attributes = FactoryGirl.attributes_for :series_with_season
        post :addShow, params: { series: @series_attributes }, format: :json
      end

      it "succeeds when" do
        series_response = JSON.parse(response.body, symbolize_names: true)
        expect(series_response[:response]).to eql "TV Series saved!"
      end

      it "passes with a legal id" do
        expect(response.status).to eq(200)
      end
    end

    context "fails when" do
      before(:each) do
        @invalid_series_attributes = {"description": "floop", "duration": 30000}
      end


      it "needs all params to be present" do
        @invalid_series_attributes[:name] = ""
        post :addShow, params: { series: @invalid_series_attributes }, format: :json
        series_response = JSON.parse(response.body, symbolize_names: true)
        expect(series_response[:status]).to eql 400
      end

    end
  end

  describe "PUT #updateShow" do
    context "when is successfully created" do
      before(:each) do
        @series = FactoryGirl.create :series_with_season
        @series_attributes = FactoryGirl.attributes_for :series_with_season
        put :updateShow, params: { series: @series_attributes, series_id: @series.id}, format: :json
      end

      it "succeeds when" do
        series_response = JSON.parse(response.body, symbolize_names: true)
        expect(series_response[:response]).to eql "TV Series successfully updated"
      end

      it "passes with a legal id" do
        expect(response.status).to eq(200)
      end
    end
  end

end
