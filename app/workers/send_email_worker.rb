class SendEmailWorker
  include Sidekiq::Worker

  def perform(email, id)
    SubscribeMailer.delay_for(5.minutes).remainder_email(email, id)
  end
end
