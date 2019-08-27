class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  
  protected

  def after_sign_in_path_for(user)
    dashboard_path || login_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end


  private
 
    def correct_user
      @artifact = Artifact.find_by_id(params[:id])
      unless @artifact && current_user  == (@artifact.user)
        flash[:danger]  = "Not Authorised To Perform The Request."
        redirect_to(root_url) 
      end
    end
    
    
end
