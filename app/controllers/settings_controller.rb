class SettingsController < ApplicationController
  before_action :set_setting, only: [:show, :edit, :update]

  def show
  end

  def edit
  end

  def update
    if @setting.update(setting_params)
      redirect_to settings_path, notice: 'Setting was successfully updated.'
    else
      render :edit
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_setting
    @setting = Setting.first
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def setting_params
    params.require(:setting).permit(:consumer_key, :consumer_secret, :prompa_url, :prompa_token, :api_token)
  end

end
