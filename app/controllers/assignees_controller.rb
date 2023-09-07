class AssigneesController < ApplicationController
	def index
		@assignees = Assignee.all
	end

	def show
		@assignee = Assignee.find(params[:id])
	end

	def new
		@assignee = Assignee.new
	end

	def create
		@task = Task.find(params[:task_id])
		@project = @task.board.project
		assignees = params[:user_ids]
		# destroy all TaskLabels for this task
		Assignee.where(task_id: @task.id).destroy_all
		unless assignees.nil? || assignees.empty?
			assignees.each do |assignee|
				Assignee.create(task_id: @task.id, user_id: assignee)
			end
		end
		redirect_to project_path(@project), notice: 'Assignees updated successfully'
	end

	def edit
		@assignee = Assignee.find(params[:id])
	end

	def update
   @assignee = Assignee.find(params[:id])
    if @assignee.update(assignee_params)
      redirect_to assignee_path(@assignee)
    else
      render :edit
    end
  end

	def destroy
		@assignee = Assignee.find(params[:id])
		@assignee.destroy
		redirect_to assignees_path
	end

	private

	def assignee_params
		params.require(:label).permit(:name, :task_id, :user_id)
	end
end
