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
		@task = Task.create(params[:task])
		redirect_to tasks_path
	end

	def edit
		@task = Task.find_by_id(params[:id])
	end

	def update
		@task = Task.update(params[:id], params[:task])
		redirect_to tasks_path
	end

	def destroy
		@task = Task.find_by_id(params[:id])
		@task.destroy
		redirect_to tasks_path
	end
end
