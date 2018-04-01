require 'rails_helper'

RSpec.describe Organizer, type: :model do
  describe "Organizer validations" do
    it "don't create if have null name field" do
      Organizer.new(name: nil).should_not be_valid
    end
    it "checks has_many relation" do
      should have_many(:events)
    end
  end
end
