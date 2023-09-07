class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    @message.user = current_user

    if @message.save
			redirect_to project_path(@message.project_id)
      # send json with user_id and message object to the project channel
      ProjectChannel.broadcast_to(
        @message.project,
        { data: @message }
      )
    else

    end
  end

  private

  def message_params
    params.require(:message).permit(:project_id, :user_id, :content)
  end
end
