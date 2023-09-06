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
		# enable_name = true only if the previous message was sent by another user
		enable_name = false
		if @message.user.id != params[:user_id].to_i
			enable_name = true
		end
		# respond_to do |format|
		# 	format.html { render json: { message: @message, enable_name: @enable_name, params: params } }
		# end
		@project = @message.project
		if @message.user == current_user
			respond_to do |format|
				format.html { render partial: "shared/projects/chat/my_message", locals: { message: @message, enable_name: enable_name } }
			end
		else
			respond_to do |format|
				format.html { render partial: "shared/projects/chat/other_message", locals: { message: @message, enable_name: enable_name } }
			end
		end
	end
end
