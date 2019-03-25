class BonusFeaturesController < ActionController::API
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
    render json: {message: "No feature with that ID found", error: record_missing_exception, status: 404}, status: 404
  end

  before_action :check_clean_params, only: [:addBonus, :updateBonus]

  def allBonuses
    @bonuses = BonusFeature.all
    render json: {response: @bonuses}
  end

  def getBonus
    @bonus = BonusFeature.find(params[:bonus_id])
    @feature = @bonus.feature
    render json: { response: {bonus: @bonus, feature: @feature} }
  end

  def addBonus
    @feature = Feature.find(params[:feature_id])
    @bonus = @feature.bonus_features.new(bonus_params)
    if @bonus.save
      render json: {response: "Bonus saved!"}
    else
      render json: {response: "Bonus failed to save"}
    end
  end

  def updateBonus
    @bonus = BonusFeature.find(params[:bonus_id])
    if @bonus.update_attributes(bonus_params)
      render json: { response: "Bonus successfully updated" }
    else
      render json: { response: "Failed to update Bonus" }
    end
  end

  def deleteBonus
    @bonus = BonusFeature.find(params[:bonus_id])
    @bonus.destroy!
    render json: { response: "Bonus successfully deleted" }
  end

  private

  def bonus_params
    begin
      params.require(:bonus).require([:name, :description, :duration])
      params.require(:bonus).permit(:name, :description, :duration)
    rescue ActionController::ParameterMissing => e
      return e
    rescue ArgumentError => e
      return e
    end
  end

  def check_clean_params
    unless params[:bonus] &&
          params[:bonus][:name].present? &&
          params[:bonus][:description].present? &&
          params[:bonus][:duration].present?

      render json: {message: "You're missing required parameters", status: 400}, status: 400
    end
  end

end
