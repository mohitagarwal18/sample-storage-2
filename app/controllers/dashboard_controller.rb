class DashboardController < ApplicationController
  before_action :logged_in_user
  def index
    @artifacts = current_user.artifacts.paginate(per_page: 5,page: params[:page])
    if params[:search_string]
      @artifacts = @artifacts.where('file_name LIKE ?', "%#{params[:search_string]}%")
    elsif params[:sorting]
      order_by , order_type = (params[:sorting]).split("-")
      @artifacts = @artifacts.order("#{order_by}  #{order_type}")
    else
      @artifacts = @artifacts.order(created_at: :desc)
    end
    @artifact = Artifact.new
  end

  

end
