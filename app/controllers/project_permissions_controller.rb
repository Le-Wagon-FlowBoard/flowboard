class ProjectPermissionsController < ApplicationController
	def index
	end

	def new
	end

	def create
		@project_permission = ProjectPermission.new(project_permission_params)
		@project = Project.find(params[:project_id])
		if @project_permission.save
			redirect_to project_path(@project), notice: 'Member added successfully'
		else
			render json: { status: @project_permission.errors.full_messages }
		end
	end

	def edit
	end

	def update
	end

	def destroy
		permission = ProjectPermission.find(params[:id])
		permission.destroy
		redirect_to project_path(permission.project), notice: 'Member removed successfully'
	end

	private
	def project_permission_params
		params.require(:project_permission).permit(:project_id, :user_id)
	end
end
