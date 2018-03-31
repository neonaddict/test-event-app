class SubscribeMailer < ApplicationMailer
  def remainder_email(email, id)
    @event = Event.find_by(id: id)
    @url = 'https://test-event-app-rails.herokuapp.com'
    mail(to: email, subject: "Напоминание о мероприятии - \"#{@event.name}\"")
  end
end
