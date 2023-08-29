class MessagesController < ApplicationController
	def index
		@messages = Message.all
	end

	def new
		@message = Message.new
	end

	def destroy
		@message = Message.find(params[:id])
		@message.destroy
		redirect_to messages_path
	end
end
