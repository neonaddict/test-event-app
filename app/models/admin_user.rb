class AdminUser < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }
  validates :email, presence: true, length: { maximum: 255 },
        format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }

end

# Returns the hash digest of the given string.
def AdminUser.password(string)
  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                              BCrypt::Engine.cost
  BCrypt::Password.create(string, cost: cost)
end
