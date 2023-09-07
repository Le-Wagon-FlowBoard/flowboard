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

	def message
		@message = Message.where(id: params[:message_id]).first
		@project = @message.project
		@messages = Message.where(project_id: @project.id).order(created_at: :asc)

		previous_user_id = nil
		enable_name = true

		@messages.each do |message|
			enable_name = previous_user_id != message.user_id
			previous_user_id = message.user_id

			if message == @message
				if message.user == current_user
					respond_to do |format|
						format.html { render partial: "shared/projects/chat/my_message", locals: { message: message, enable_name: enable_name } }
					end
				else
					respond_to do |format|
						format.html { render partial: "shared/projects/chat/other_message", locals: { message: message, enable_name: enable_name } }
					end
				end
				break
			end
		end
	end
end
