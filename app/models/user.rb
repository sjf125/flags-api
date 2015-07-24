class User < ActiveRecord::Base
  has_secure_password

  before_create :set_token

  validates :email, uniqueness: true

  def self.login(email, password)
    user = find_by email: email
    user = user.authenticate password if user
    user.set_token && user.save! if user
    user.token if user
  end

  def set_token
    self.token = SecureRandom.hex
  end
end
