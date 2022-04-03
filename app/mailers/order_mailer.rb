class OrderMailer < ApplicationMailer
  def send_confirmation(order)
    @order = order
    @store = @order.store
    @products = @order.products

    mail(to: @store.email, subject: 'Nueva orden de pedido')
  end
end
