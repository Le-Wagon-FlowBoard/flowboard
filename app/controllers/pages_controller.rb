class PagesController < ApplicationController
	skip_before_action :authenticate_user!, only: [ :home ]

	def home
	end

	def add_label_modal
		@task = Task.find(params[:task_id])
		@project = @task.board.project
		@label = Label.new
		respond_to do |format|
			format.html { render partial: "shared/projects/labels/add", locals: { task: @task } }
		end
	end

	def add_deadline_modal
		@task = Task.find(params[:task_id])
		@project = @task.board.project
		respond_to do |format|
			format.html { render partial: "shared/projects/boards/deadline", locals: { task: @task } }
		end
	end

	def add_assignee_modal
		@task = Task.find(params[:task_id])
		@project = @task.board.project
		respond_to do |format|
			format.html { render partial: "shared/projects/boards/assignee", locals: { task: @task } }
		end
	end
end
