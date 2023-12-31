class TaskLabelsController < ApplicationController
	def create
		@task = Task.find(params[:task_id])
		@project = @task.board.project
		labels = params[:label_ids]
		# destroy all TaskLabels for this task
		TaskLabel.where(task_id: @task.id).destroy_all
		unless labels.nil? || labels.empty?
			labels.each do |label|
				TaskLabel.create(task_id: @task.id, label_id: label)
			end
		end
		redirect_to project_path(@project), notice: 'Labels updated successfully'
	end

	def destroy
		@task = Task.find(params[:task_id])
		@label = Label.find(params[:label_id])
		@task.labels.delete(@label)
		redirect_to task_path(@task)
	end

	def show
		@label = Label.find(params[:id])
		@tasks = @label.tasks
	end

	def index
		@labels = Label.all
	end

	def new
		@task = Task.find(params[:task_id])
		@label = Label.new
	end

	def edit
		@task = Task.find(params[:task_id])
		@label = Label.find(params[:id])
	end

	def update
		@task = Task.find(params[:task_id])
		@label = Label.find(params[:id])
		@label.update(label_params)
		redirect_to task_path(@task)
	end

	def destroy
		@task = Task.find(params[:task_id])
		@label = Label.find(params[:id])
		@label.destroy
		redirect_to task_path(@task)
	end

	private

	def label_params
		params.require(:label).permit(:name, :task_id, :label_id)
	end

end
