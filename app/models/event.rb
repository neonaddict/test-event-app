class Event < ApplicationRecord
  has_attached_file :event_image, styles: { medium: '300x300#', thumb: '100x100#' }, default_url: 'images/:style/missing.png',
                                  storage: :s3, 
                                  bucket: 'test-event-app-rails', 
                                  s3_protocol: 'https'

  validates_attachment_content_type :event_image, content_type: /\Aimage\/.*\z/

  scope :city_filter, ->(city) { where('city = ?', city) if city.present? }
  scope :month_filter, ->(month) { where('extract(month  from date) = ?', month) if month.present? }
  scope :organizer_filter, ->(organizer_id) { where('organizer_id = ?', organizer_id) if organizer_id.present? }
  scope :past_or_upcoming_filter, ->(par) { where("date #{par} ?", DateTime.now) }
end
