class User < ActiveRecord::Base
  has_secure_password

  before_create :set_token

  validates :email, uniqueness: true

  private

  def set_token
    self.token = SecureRandom.hex
  end
end
