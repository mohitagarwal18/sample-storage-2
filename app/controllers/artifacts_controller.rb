class ArtifactsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:destroy , :download]
  def create
    if params[:artifact] && params[:artifact][:file]
      artifact = params[:artifact][:file]
      if artifact.size <= 100.megabyte
        dir = Rails.root.join('public', 'uploads', current_user.id.to_s)
        Dir.mkdir(dir) unless Dir.exist?(dir)
        File.open(dir.join(artifact.original_filename), 'wb') do |file|
          file.write(artifact.read)
        end
        saved_artifact = current_user.artifacts.create(file_location:  dir.join(artifact.original_filename.to_s) , file_size: artifact.size, file_name: artifact.original_filename)
        if saved_artifact.errors.any?
          flash[:danger] = saved_artifact.errors.full_messages.join(", ")
        else
          saved_artifact.save
          flash[:success] = "File Uploaded Successfully"
        end
      else
        flash[:danger] = "Max File Limit is 100MB"
      end
    else
      flash[:danger] = "Invalid File"
    end
    redirect_to dashboard_url
  end

  def destroy
    File.delete(@artifact.file_location) if File.exist?(@artifact.file_location)
    @artifact.destroy
    flash[:success] = "File Deleted Successfully"
    redirect_to dashboard_url
  end
  def download
    send_file @artifact.file_location
  end

  private

    def artifact_params
      params.require(:artifact).permit(:file)
    end

end

