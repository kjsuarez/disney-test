require 'spec_helper'
describe BonusFeaturesController do

  describe "GET #getBonus" do
    before(:each) do
      @feature = FactoryGirl.create :feature_with_bonus
      @bonus = @feature.bonus_features.first
      get :getBonus, params: { bonus_id: @bonus.id }, format: :json
    end

    it "returns the feature" do
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:response][:bonus][:name]).to eql @bonus.name
    end

    it "passes with a legal id" do
      expect(response.status).to eq(200)
    end
  end

  describe "GET #getFeature with bad id" do
    before(:each) do
      @feature = FactoryGirl.create :feature_with_bonus
      @bonus = @feature.bonus_features.first
      get :getBonus, params: { bonus_id: 1000 }, format: :json
    end

    it "returns gracefull error" do
      output = JSON.parse(response.body, symbolize_names: true)
      expect(output[:error]).to eql "Couldn't find BonusFeature with 'id'=1000"
    end

    it "failed gracefully with a bad id" do
      expect(response.status).to eq(404)
    end
  end

  describe "POST #addBonus" do

    context "when is successfully created" do
      before(:each) do
        @feature = FactoryGirl.create :feature_with_bonus
        @bonus_attributes = FactoryGirl.attributes_for :bonus_feature
        post :addBonus, params: { bonus: @bonus_attributes, feature_id: @feature.id }, format: :json
      end

      it "succeeds when" do
        bonus_response = JSON.parse(response.body, symbolize_names: true)
        expect(bonus_response[:response]).to eql "Bonus saved!"
      end

      it "passes with a legal id" do
        expect(response.status).to eq(200)
      end
    end

    context "fails when" do
      before(:each) do
        @feature = FactoryGirl.create :feature_with_bonus
        @invalid_bonus_attributes = {"description": "floop", "duration": 30000}
      end


      it "needs all params to be present" do
        @invalid_bonus_attributes[:name] = ""
        post :addBonus, params: { bonus: @invalid_bonus_attributes, feature_id: @feature.id }, format: :json
        feature_response = JSON.parse(response.body, symbolize_names: true)
        expect(feature_response[:status]).to eql 400
      end

    end
  end

  describe "PUT #updateBonus" do
    context "when is successfully created" do
      before(:each) do
        @feature = FactoryGirl.create :feature_with_bonus
        @bonus = @feature.bonus_features.first
        @bonus_attributes = FactoryGirl.attributes_for :bonus_feature
        put :updateBonus, params: { bonus: @bonus_attributes, bonus_id: @bonus.id }, format: :json
      end

      it "succeeds when" do
        bonus_response = JSON.parse(response.body, symbolize_names: true)
        expect(bonus_response[:response]).to eql "Bonus successfully updated"
      end

      it "passes with a legal id" do
        expect(response.status).to eq(200)
      end
    end
  end

end
