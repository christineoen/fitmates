class ConversationsController < ApplicationController

  def index
  end

  def show
    @message = Message.new
    @messages = Message.where(conversation_id: params['id'])
  end

  def create

  # when a user clicks 'send message' on another users profile, this query looks to see if a
  # conversation already exists between the two users.  It is finding all conversations where
  # the user is either the current user or the user they would like to send a message to.  There
  # will be one conversation that appears twice if they are both involved in the same conversation,
  # so I group by conversation id, and find the one that has a value of two.
  conversation = Conversation.joins(:participants)
    .where(:participants => { :user_id => [current_user.id, params['send_to_id']] })
    .group('conversations.id')
    .having('COUNT("conversations"."id")=2')

  # if a conversation doesn't exist already, it creates a new conversation.  If it does exist,
  # it retirects to that conversation so they can see previous messages and add more messages.
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