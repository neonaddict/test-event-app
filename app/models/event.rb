class Event < ApplicationRecord
  require 'icalendar'

  belongs_to :organizer
  has_attached_file :event_image, styles: { medium: '300x300#', thumb: '100x100#' },
                                  storage: :s3, 
                                  bucket: 'test-event-app-rails', 
                                  s3_protocol: 'https'
  
  validates_attachment_content_type :event_image, content_type: /\Aimage\/.*\z/, presence: true
  validates_presence_of :name

  scope :city_filter, ->(city) { where city: city if city.present? }
  scope :month_filter, ->(month) { where('extract(month  from date) = ?', month) if month.present? }
  scope :organizer_filter, ->(organizer_id) { where organizer_id: organizer_id if organizer_id.present? }
  scope :past_or_upcoming_filter, ->(par) { where("date #{par} ?", DateTime.now) if par.present? }

  def self.filter(filter_params)
    Event.city_filter(filter_params[:city])
         .month_filter(filter_params[:month])
         .organizer_filter(filter_params[:organizer_id])
         .past_or_upcoming_filter(filter_params[:par])
         .order('date DESC')
  end

  def ics_create
    filename = "#{name}.ics"
    # Create a calendar with an event (standard method)
    cal = Icalendar::Calendar.new
    cal.event do |e|
      e.dtstart     = date
      e.dtend       = date
      e.summary     = name
      e.description = description
      e.location    = "#{city}, #{address}"
    end
  end

end
