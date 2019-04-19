class EmailController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def save_order
    puts params

    order = Order.new

    order.email = params["email"]
    order.name = params["customer"]["first_name"]
    order.number = params["number"]
    order.line_items = params["line_items"]

    order.save

    Mailchimp.delay(run_at: 50.days.from_now).replenishment_email(order)

    head :ok
  end

  def save_order_test
    puts params

    order = Order.new

    order.email = params["email"]
    order.name = params["customer"]["first_name"]
    order.number = params["number"]
    order.line_items = params["line_items"]

    order.save

    Mailchimp.delay.replenishment_email(order)

    head :ok
  end

end
