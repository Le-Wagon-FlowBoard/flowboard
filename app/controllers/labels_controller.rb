class LabelsController < ApplicationController
	def index
    @labels = Label.all
	end

	def show
		@label = Label.find(params[:id])
	end

	def new
		@label = Label.new
		@label.build_address
	end

	def create
		@label = Label.new(label_params)
		@project = Project.find(params[:project_id])
		if @label.save
			redirect_to project_path(@project), notice: 'Label created successfully'
		else
			render json: { status: @label.errors.full_messages }
		end
	end

	def edit
		@label = Label.find(params[:id])
	end

	def update
		@label = Label.find(params[:id])
		@project = Project.find(params[:project_id])
		if @label.update(label_params)
			redirect_to project_path(@project), notice: 'Label updated successfully'
		else
			render 'edit'
		end
	end

	def destroy
		@label = Label.find(params[:id])
		@label.destroy
		redirect_to labels_path
	end

	private

	def label_params
		params.require(:label).permit(:name, :color, :project_id)
	end
end
