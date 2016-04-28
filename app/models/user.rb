#
class User < ActiveRecord::Base
  include Authentication
  has_many :ratings
  has_many :comments
end
