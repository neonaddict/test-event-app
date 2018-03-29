class SubscribeMailer < ApplicationMailer
    
    def remainder_email(email, id)
        @event = Event.find_by(id: id)
        @url  = 'localhost:8000'
        mail(to: email, subject: "Напоминание о мероприятии - \"#{@event.name}\"")
    end
end
