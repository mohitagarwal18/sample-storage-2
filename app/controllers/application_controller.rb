class ApplicationController < ActionController::Base
  include SessionsHelper
  


  private
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to "/login"
      end
    end
    def correct_user
      @artifact = Artifact.find_by_id(params[:id])
      unless current_user?(@artifact.user)
        flash[:danger]  = "Not Authorised To Perform The Request."
        redirect_to(root_url) 
      end
    end
    
end
