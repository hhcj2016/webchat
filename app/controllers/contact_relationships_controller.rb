class ContactRelationshipsController < ApplicationController

  before_action :authenticate_user!

   def index
     @contacts = current_user.contacts
   end

   def create
     @contact_relationship = current_user.contact_relationships.build(:contact_id => params[:contact_id])
     if @contact_relationship.save
       flash[:notice] = "Added contact."
       redirect_to root_url
     else
       flash[:error] = "Unable to add contact."
       redirect_to root_url
     end
   end

   def destroy
     @contact_relationship = current_user.contact_relationships.find_by(contact_id: params[:id])
     @contact_relationship.destroy
     flash[:notice] = "Removed contact."
     redirect_to root_url
   end

end
