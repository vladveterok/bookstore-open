class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.sender[:email]
  layout 'mailer'
end
