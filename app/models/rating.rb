class Rating < ActiveRecord::Base
  belongs_to :user, inverse_of: :ratings
  belongs_to :flag, inverse_of: :ratings
end
