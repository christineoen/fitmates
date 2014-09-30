class ConversationsController < ApplicationController

  def index
  end

  def show
    @message = Message.new
    @messages = Message.where(conversation_id: params['id'])
  end

  def create
  conversation = Conversation.joins(:participants).where(participants: {user_id: [current_user.id, params['send_to_id']]})
    if conversation[0] == nil
      @conversation = Conversation.create
      Participant.create(conversation_id: @conversation.id, user_id: current_user.id)
      Participant.create(conversation_id: @conversation.id, user_id: params['send_to_id'])
      redirect_to @conversation
    else
      redirect_to "/conversations/#{conversation[0].id}"
    end
  end

end