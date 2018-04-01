require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe "AdminUser validations" do
    it "validate email and check uniqueness" do
      AdminUser.new(email: nil).should_not be_valid
      AdminUser.new(email: 'sdsdasdasdas').should_not be_valid
      u = AdminUser.create(email: 'test@test.com')
      AdminUser.new(email: 'test@test.com').should_not be_valid
    end
    it "validate password" do
      AdminUser.new(password: nil).should_not be_valid
      AdminUser.new(password:'1234567').should_not be_valid
    end
  end
end
