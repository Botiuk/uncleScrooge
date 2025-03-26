# frozen_string_literal: true

class MainController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index contacts]
  authorize_resource class: false

  def index
    last_product_ids = Storehouse.where(operation_type: 'input')
                                 .where(updated_at: (Time.zone.today - 1.week)..Time.zone.today)
                                 .order(updated_at: :desc).pluck(:product_id)
    @products = Product.where(id: last_product_ids)
    avaliable_products_hash
    @sale_products = Product.where(id: @sales.keys)
  end

  def contacts; end

  def user_profile
    @discount = current_user.discount.percentage
    @orders = Order.joins(:cart).where(carts: { user_id: current_user.id }).order(created_at: :desc)
    @delivery_addresses = DeliveryAddress.where(user_id: current_user.id)
    @payment_cards = PaymentCard.where(user_id: current_user.id)
  end
end
