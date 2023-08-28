class ProjectPermissionsController < ApplicationController
  def index
    @project_permissions = ProjectPermission.all
  end

  def new
    @project_permission = ProjectPermission.new
  end

  def create
    @project_permission = ProjectPermission.new(project_permission_params)
    if @project_permission.save
      redirect_to project_permissions_path
    else
      render 'new'
    end
  end

  def edit
    @project_permission = ProjectPermission.find(params[:id])
  end

  def update
    @project_permission = ProjectPermission.find(params[:id])
    if @project_permission.update(project_permission_params)
      redirect_to project_permissions_path
    else
      render 'edit'
    end
  end

  def destroy
    @project_permission = ProjectPermission.find(params[:id])
    @project_permission.destroy
    redirect_to project_permissions_path
  end

  private
  def project_permission_params
    params.require(:project_permission).permit(:project_id, :user_id, :permission_id)
  end
end
