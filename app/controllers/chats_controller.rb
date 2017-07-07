class ChatsController < ApplicationController

  before_action :authenticate_user!
   def index
     @users = User.all
     @chats = Chat.all
   end


   def create

     if Chat.between(params[:sender_id],params[:recipient_id])
       .present?
       @chat = Chat.between(params[:sender_id],
                                            params[:recipient_id]).first
     else
       @chat = Chat.create!(chat_params)

       @contact_relationship = current_user.contact_relationships.build(:contact_id => params[:recipient_id])
       @contact_relationship.save

       @contact = User.find(params[:recipient_id])
       @contact_relationship = @contact.contact_relationships.build(:contact_id => current_user.id)
       @contact_relationship.save
     end

     redirect_to chat_messages_path(@chat)
   end

   private
   def chat_params
     params.permit(:sender_id, :recipient_id)
   end

end
