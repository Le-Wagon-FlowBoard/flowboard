class BoardsController < ApplicationController
  before_action :set_project, only: [:create]
	def index
		@boards = Board.where(project_id: params[:id])
    @board = Board.new
	end

	def show
		@board = Board.find_by(id: params[:id])
	end

	def new
		@board = Board.new
	end

	def create
		@board = Board.new
		@board.name = params[:board][:name]
    @board.description = params[:board][:description]
    @board.project_id = params[:project_id]
		@board.save
		redirect_to project_path(@project)
	end

	def edit
		@board = Board.find_by(id: params[:id])
	end

	def update
		@board = Board.find_by(id: params[:id])
		@board.title = params[:board][:title]
		@board.save
		redirect_to board_path(@board)
	end

	def destroy
		@board = Board.find_by(id: params[:id])
		@board.destroy
		redirect_to projects_path
	end
  def set_project
    @project = Project.find_by_id(params[:project_id])

  end
end
