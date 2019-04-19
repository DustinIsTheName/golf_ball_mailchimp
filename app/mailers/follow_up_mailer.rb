class FollowUpMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)

  default to: 'dustin@wittycreative.com'

  def replenishment(order)

    @order = order
    @order_line_items = []
    @line_item_images = []

    for line_item in @order.line_items

      p = ShopifyAPI::Product.find line_item["product_id"]

      if p.product_type == "Golf Balls"
        @order_line_items << line_item

        if line_item["variant_id"]
          @line_item_images << p.images.select{|i| i.variant_ids.include? line_item["variant_id"]}.first.src
        else
          @line_item_images << p.image.src
        end
      end
    end

    if @order_line_items.length > 0
      mail(to: order.email, from: 'golfballnut@no-reply.com', subject: 'Time to restock? You\'re one click away.')
      puts Colorize.green "Sent Email"
    else
      puts Colorize.cyan "Don't send"
    end

    order.destroy

  end


end