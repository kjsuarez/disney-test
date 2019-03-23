class ApplicationController < ActionController::API
  def hello
    features = Feature.all
    render json: {features: features}
  end
end
