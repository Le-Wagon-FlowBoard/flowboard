class ProjectChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    project = Project.find(params[:project_id])
    stream_for project
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
