class Flag < ActiveRecord::Base
  has_many :ratings, inverse_of: :flags
  has_many :comments, inverse_of: :flags
end
