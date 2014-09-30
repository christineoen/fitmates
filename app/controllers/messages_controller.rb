class MessagesController < ApplicationController

  def create
    conversation = Conversation.find(message_params['conversation_id'])
    @message = Message.new(message_params)
    @message.save
    redirect_to conversation
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id, :conversation_id)
  end

end