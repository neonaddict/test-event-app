class SendEmailWorker
  include Sidekiq::Worker

  # Send email after 5 minutes
  def perform(email, id)
    SubscribeMailer.delay_for(5.minutes).remainder_email(email, id)
  end
end
