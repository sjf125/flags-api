class Comment < ActiveRecord::Base
  belongs_to :user, inverse_of: :comments
  belongs_to :flag, inverse_of: :comments
  validates_presence_of :content
end
