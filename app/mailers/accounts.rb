class Accounts < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.accounts.confirm_registration.subject
  #
  def confirm_registration
    @greeting = "Hi"

    mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.accounts.reset_password.subject
  #
  def reset_password
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
