# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    storehouses_ids = CartStorehouse.where(cart_id: @cart.id).pluck(:storehouse_id)
    @pagy, @storehouses = pagy(Storehouse.includes(:product).where(id: storehouses_ids).order(:created_at), limit: 30)
    @cart_price = 0
    @cart_items = 0
    cart_total if @storehouses.present?
  rescue Pagy::OverflowError
    redirect_to @cart
  end

  def add_to_cart
    @product = Product.find_by(id: params[:product_id])
    quantity = params[:quantity].to_i
    storehouse_record = @cart.storehouses.find_by(product_id: @product.id)
    if storehouse_record.present?
      new_quantity = storehouse_record.quantity + quantity
      storehouse_record.update(quantity: new_quantity)
    else
      new_storehouse = Storehouse.create(product_id: params[:product_id], operation_type: 'cart', quantity: quantity)
      CartStorehouse.create(cart_id: @cart.id, storehouse_id: new_storehouse.id)
    end
  end

  def remove_from_cart; end

  private

  def cart_total
    @storehouses.each do |storehouse|
      @cart_price += storehouse.quantity * storehouse.product.price
      @cart_items += storehouse.quantity
    end
  end
end
