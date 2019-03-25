require 'spec_helper'
describe FeaturesController do

  describe "GET #getFeature" do
    before(:each) do
      @feature = FactoryGirl.create :feature_with_bonus
      get :getFeature, params: { feature_id: @feature.id }, format: :json
    end

    it "returns the feature" do
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:response][:feature][:name]).to eql @feature.name
    end

    it "passes with a legal id" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET #getFeature with bad id" do
    before(:each) do
      @feature = FactoryGirl.create :feature_with_bonus
      get :getFeature, params: { feature_id: 1000 }, format: :json
    end

    it "returns gracefull error" do
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:error]).to eql "Couldn't find Feature with 'id'=1000"
    end

    it "failed gracefully with a bad id" do
      expect(response.status).to eq(404)
    end
  end

  describe "POST #addFeature" do

    context "when is successfully created" do
      before(:each) do
        @feature_attributes = FactoryGirl.attributes_for :feature
        post :addFeature, params: { feature: @feature_attributes }, format: :json
      end

      it "renders the json representation for the feature record just created" do
        feature_response = JSON.parse(response.body, symbolize_names: true)
        expect(feature_response[:response]).to eql "feature saved!"
      end

      it "passes with a legal id" do
        expect(response.status).to eq(200)
      end
    end

    context "fails when" do
      before(:each) do
        @invalid_user_attributes = { "name": "moop",
           "description": "floop",
            "theatricalReleaseDate": "11/27/2013",
             "duration": 30000 }

      end

      it "needs a legal date string" do
        post :addFeature, params: { feature: @invalid_user_attributes }, format: :json

        feature_response = JSON.parse(response.body, symbolize_names: true)
        expect(feature_response).to have_key(:error)
      end

      it "needs all params to be present" do
        @invalid_user_attributes[:name] = ""
        post :addFeature, params: { feature: @invalid_user_attributes }, format: :json
        feature_response = JSON.parse(response.body, symbolize_names: true)
        expect(feature_response[:status]).to eql 400
      end

    end
  end

  describe "PUT #updateBonus" do
    context "when is successfully created" do
      before(:each) do
        @feature = FactoryGirl.create :feature_with_bonus
        @feature_attributes = FactoryGirl.attributes_for :feature
        put :updateFeature, params: { feature: @feature_attributes, feature_id: @feature.id }, format: :json
      end

      it "succeeds when" do
        feature_response = JSON.parse(response.body, symbolize_names: true)
        expect(feature_response[:response]).to eql "Feature successfully updated"
      end

      it "passes with a legal id" do
        expect(response.status).to eq(200)
      end
    end
  end
end
