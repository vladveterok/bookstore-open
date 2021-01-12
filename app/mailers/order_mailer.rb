class OrderMailer < ApplicationMailer
  def order_confirmation_mail(cart)
    @cart = CartDecorator.decorate(cart)
    mail(to: @cart.user.email, subject: I18n.t('checkout.mailer.subject', number: @cart.order_number))
  end
end
