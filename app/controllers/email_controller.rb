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

    theme = ShopifyAPI::Theme.where({'role': "main"}).first
    asset = ShopifyAPI::Asset.find('config/settings_data.json', :params => {:theme_id => theme.id})
    settings = JSON.parse asset.value

    Mailchimp.delay(run_at: settings["current"]["follow_up_email_delay"].to_i.days.from_now).replenishment_email(order)

    head :ok
  end

  def save_order_test_delay
    puts params

    order = Order.new

    order.email = params["email"]
    order.name = params["customer"]["first_name"]
    order.number = params["number"]
    order.line_items = params["line_items"]

    order.save

    Mailchimp.delay(run_at: 5.minutes.from_now).replenishment_email(order)

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
