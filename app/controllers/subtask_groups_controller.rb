class SubtaskGroupsController < ApplicationController
  before_action :set_subtask_group, only: [:show, :edit, :update, :destroy]

  # GET /subtask_groups
  # GET /subtask_groups.json
  def index
    @subtask_groups = SubtaskGroup.all
  end

  # GET /subtask_groups/1
  # GET /subtask_groups/1.json
  def show
    @subtask_group = SubtaskGroup.find(params[:id])
  end

  # GET /subtask_groups/new
  def new
    @subtask_group = SubtaskGroup.new
  end

  # GET /subtask_groups/1/edit
  def edit
    @substask_group = SubtaskGroup.find(params[:id])
  end

  # POST /subtask_groups
  # POST /subtask_groups.json
  def create
    @subtask_group = SubtaskGroup.new(subtask_group_params)

    respond_to do |format|
      if @subtask_group.save
        format.html { redirect_to @subtask_group, notice: 'Subtask group was successfully created.' }
        format.json { render :show, status: :created, location: @subtask_group }
      else
        format.html { render :new }
        format.json { render json: @subtask_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subtask_groups/1
  # PATCH/PUT /subtask_groups/1.json
  def update
    respond_to do |format|
      if @subtask_group.update(subtask_group_params)
        format.html { redirect_to @subtask_group, notice: 'Subtask group was successfully updated.' }
        format.json { render :show, status: :ok, location: @subtask_group }
      else
        format.html { render :edit }
        format.json { render json: @subtask_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subtask_groups/1
  # DELETE /subtask_groups/1.json
  def destroy
    @subtask_group.destroy
    respond_to do |format|
      format.html { redirect_to subtask_groups_url, notice: 'Subtask group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_subtask
    @subtask_group = SubtaskGroup.find(params[:id])
    @subtask = Subtask.new
    @
end
