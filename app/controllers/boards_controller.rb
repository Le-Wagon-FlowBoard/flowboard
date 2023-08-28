class BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def show
    @board = Board.find_by(id: params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new
    @board.title = params[:board][:title]
    @board.save
    redirect_to board_path(@board)
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
    redirect_to boards_path
  end
end
