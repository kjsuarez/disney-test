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

    it "passes with a legal id" do
      expect(response.status).to eq(404)
    end
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @feature_attributes = FactoryGirl.attributes_for :feature
        post :addFeature, { feature: @feature_attributes }, format: :json
      end

      # it "renders the json representation for the feature record just created" do
      #   user_response = JSON.parse(response.body, symbolize_names: true)
      #   expect(user_response[:email]).to eql @user_attributes[:email]
      # end

      it { should respond_with 201 }
    end

    # context "when is not created" do
    #   before(:each) do
    #     #notice I'm not including the email
    #     @invalid_user_attributes = { password: "12345678",
    #                                  password_confirmation: "12345678" }
    #     post :create, { user: @invalid_user_attributes }, format: :json
    #   end
    #
    #   it "renders an errors json" do
    #     user_response = JSON.parse(response.body, symbolize_names: true)
    #     expect(user_response).to have_key(:errors)
    #   end
    #
    #   it "renders the json errors on why the user could not be created" do
    #     user_response = JSON.parse(response.body, symbolize_names: true)
    #     expect(user_response[:errors][:email]).to include "can't be blank"
    #   end
    #
    #   it { should respond_with 422 }
    # end
  end
end
