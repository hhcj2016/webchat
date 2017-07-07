class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


         has_many :contacts, :through => :contact_relationships
         has_many :contact_relationships


         def unread(user, contact)
           chat = Chat.between(user.id, contact.id).first
           if !chat.nil?
             chat.messages.where(read: false, user_id: contact.id).count
           else
             0
           end
         end


end
