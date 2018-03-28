class Event < ApplicationRecord
  has_attached_file :event_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "images/:style/missing.png"
  validates_attachment_content_type :event_image, content_type: /\Aimage\/.*\z/
end
