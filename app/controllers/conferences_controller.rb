class ConferencesController < ApplicationController
  def index
    @conferences = Conference.all
  end

  def show
    @conference = Conference.find(params[:id])
  end

  def new
    @conference = Conference.new
  end

  def create
    @conference = Conference.new(conference_params)
    if @conference.save
      redirect_to @conference
    else
      render 'new'
    end
  end

  def edit
    @conference = Conference.find(params[:id])
  end

  def update
    @conference = Conference.find(params[:id])
    if @conference.update(conference_params)
      redirect_to @conference
    else
      render 'edit'
    end
  end

  def destroy
    @conference = Conference.find(params[:id])
    @conference.destroy
    redirect_to conferences_path
  end

  private

  def conference_params
    params.require(:conference).permit(:name, :description)
  end
end
