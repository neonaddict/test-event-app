require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "Event validations" do
    it "don't create if have null name field" do
      Event.new(name: nil).should_not be_valid
    end
    it "validate image" do
      should have_attached_file(:event_image)
      should validate_attachment_content_type(:event_image).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml')
    end  
  end
end
