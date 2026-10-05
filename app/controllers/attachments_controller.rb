class AttachmentsController < ApplicationController
  def destroy
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
    redirect_back fallback_location: root_path, status: :see_other, notice: "Photo successfully removed."
  end
end