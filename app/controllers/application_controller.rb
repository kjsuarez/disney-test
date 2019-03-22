class ApplicationController < ActionController::API
  def hello
    render json: {json: 'rails get response'}
  end
end
