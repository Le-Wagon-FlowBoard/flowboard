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
      if @label.save
        redirect_to @label
      else
        render 'new'
      end
    end

    def edit
      @label = Label.find(params[:id])
    end

    def update
      @label = Label.find(params[:id])
      if @label.update(label_params)
        redirect_to @label
      else
        render 'edit'
      end
    end

    def destroy
      @label = Label.find(params[:id])
      @label.destroy
      redirect_to labels_path
end
