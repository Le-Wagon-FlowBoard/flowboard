class TasksController < ApplicationController
	def index
		@tasks = Task.all
	end

	def show

		@task = Task.find_by_id(params[:id])
	end

	def new

		@task = Task.new
	end

	def create
		@task = Task.create(name: params[:task_name], board_id: params[:board_id])
		if @task.save
			render json: @task
		else
			render json: { status: @task.errors.full_messages }
		end
	end

	def edit
		@task = Task.find_by_id(params[:id])
	end

	def update
    @task = Task.find_by_id(params[:task_id])  # Use 'params[:id]' instead of 'params[:task_id]'

    if @task.update(task_params)
      render json: { status: 'Task updated successfully' }
    else
      render json: { status: @task.errors.full_messages }
    end
  end

	def destroy
		@task = Task.find_by_id(params[:id])
		@task.destroy
		redirect_to tasks_path
	end

	private

	def task_params
    params.require(:task).permit(:project_id, :board_id, :position, :task_id, :task_name)
  end
end
