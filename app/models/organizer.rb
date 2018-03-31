class Organizer < ApplicationRecord
  has_many :events

  accepts_nested_attributes_for :events
end
