# frozen_string_literal: true

# Mailer template for sending a mail
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
