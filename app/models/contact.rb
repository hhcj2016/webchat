class Contact < ApplicationRecord
  has_many :contact_relationships
  has_many :members, through: :contact_relationships, source: :user
end
