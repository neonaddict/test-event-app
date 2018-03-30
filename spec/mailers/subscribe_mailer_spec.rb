require "rails_helper"

RSpec.describe "Test sending email with sidekiq", type: :request do
=begin
  
it 'send email to sidekiq' do

  #get "/events/1"
  #expect(response).to render_template(:show)

  post "/events/1/subscribe", params: {email: 'james095@yandex.ru', id: 1}
  
  expect{
    SubscribeMailer.delay_for(5.minutes).remainder_email(email, id)
  }.to change( SendEmailWorker.jobs, :size ).by(1)

end

  
=end

end
