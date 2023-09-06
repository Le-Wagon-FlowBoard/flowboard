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

		@assignee = Assignee.new(assignee_params)
		if @assignee.save
			redirect_to assignees_path, notice: "Assignee was successfully created."
		else
			render :new, notice: "Assignee was not created."
		end
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
		params.require(:assignee).permit(:task_id, user_ids: [])
	end
end
