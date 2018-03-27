class AdminUser < ApplicationRecord
    has_secure_password
    validates :password, presence: true, length: { minimum: 8 }
end

    # Returns the hash digest of the given string.
    def AdminUser.password(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end 