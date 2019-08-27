class DashboardController < ApplicationController
  before_action :authenticate_user! , except: [:index]
  def index
    if current_user
      @artifacts = current_user.artifacts.page(params[:page]).per(5)
      if params[:search_string]
        @artifacts = @artifacts.ransack("file_name_cont" => params[:search_string]).result.all
        
      elsif params[:sorting]
        order_by , order_type = (params[:sorting]).split("-")
        @artifacts = @artifacts.order("#{order_by}  #{order_type}")
      else
        @artifacts = @artifacts.order(created_at: :desc)
      end
      @artifact = Artifact.new
    else
      redirect_to login_path
    end
  end

  

end
