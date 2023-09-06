class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # do not add if project.user_id = current_user.id
  def index
    all_project_ids = current_user.project_ids + current_user.permitted_project_ids
    @projects = Project.where(id: all_project_ids)
    @project = Project.new
  end

  def show
    @project = Project.find_by_id(params[:id])
    @board = Board.new
    @boards = Board.where(project_id: @project.id)
    @label = Label.new
    @labels = Label.where(project_id: @project.id)
    @task = Task.new
    @tasks = Task.where(project_id: @project.id)
    @project_permission = ProjectPermission.new
    @project_permissions = @project.project_permissions
    @assignee = Assignee.new

  end


  def new
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      redirect_to projects_path, notice: 'Project was successfully created.'
    else
      @projects = Project.all
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

	def update

		if @project.update(project_params)
			redirect_to project_path(@project), notice: 'Project was successfully updated.'
		else
			render :index, status: :unprocessable_entity
		end
	end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find_by_id(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description, :user_id)
  end
end
