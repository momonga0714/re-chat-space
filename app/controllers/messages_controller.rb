class MessagesController < ApplicationController

  def index
    # @messages = Message.all
  end

  def new
    @message = Message.new
    @message.user << current_user
  end

  def create
    @message = Message.create(message_set)
  end


  private
  def message_set
    params.require(:message).permit(:message)
  end
end
