class SubtasksController < ApplicationController
  before_action :set_subtask, only: [:show, :edit, :update, :destroy]

  # GET /subtasks
  def index
    @subtasks = Subtask.all
  end

  # GET /subtasks/1
  def show
  end

  # GET /subtasks/new
  def new
    @subtask = Subtask.new
  end

  # GET /subtasks/1/edit
  def edit
    @subtask = Subtask.find(params[:id])
  end

  # POST /subtasks
  def create
    @subtask = Subtask.new(subtask_params)

    if @subtask.save
      redirect_to @subtask, notice: 'Subtask was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /subtasks/1
  def update
    if @subtask.update(subtask_params)
      redirect_to @subtask, notice: 'Subtask was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /subtasks/1
  def destroy
    @subtask.destroy
    redirect_to subtasks_url, notice: 'Subtask was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subtask
      @subtask = Subtask.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subtask_params
      params.require(:subtask).permit(:title, :description, :completed, :task_id)
    end
end
