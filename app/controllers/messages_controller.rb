class MessagesController < ApplicationController

  before_action do
     @chat = Chat.find(params[:chat_id])
   end

   respond_to :html, :js

   def index
     @messages = @chat.messages

     if @messages.length > 5
       @over_ten = true
       @messages = @messages[-5..-1]
     end

     if params[:m]
       @over_ten = false
       @messages = @chat.messages
     end

     if @messages.last
       if @messages.last.user_id != current_user.id
         @messages.each do |message|
           message.update(read: 'true')
         end
       end
     end

     @message = @chat.messages.new
   end

   def new
     @message = @chat.messages.new
   end

   def create
     @message = @chat.messages.new(message_params)

     if @message.save

     end
     redirect_to :back
   end

   def destroy
     @message = @chat.messages.find(params[:id])
     @message.destroy


     redirect_to :back
   end

   private

   def message_params
     params.require(:message).permit(:body, :user_id)
   end

end
