# frozen_string_literal: true

class CartsController < ApplicationController
  before_action :set_storehouse, only: %i[remove_from_cart minus_one_item plus_one_item]
  before_action :check_product_avaliable, only: %i[add_to_cart plus_one_item]
  authorize_resource

  def destroy
    @cart.storehouses.each(&:destroy)
    @cart.destroy
    redirect_to root_path, notice: t('notice.destroy.cart')
  end

  def my_cart
    storehouses_ids = CartStorehouse.where(cart_id: @cart.id).pluck(:storehouse_id)
    @pagy, @storehouses = pagy(Storehouse.includes(:product).where(id: storehouses_ids).order(:created_at), limit: 30)
    @discount = Discount.where(user_id: @cart.user_id).first.percentage
    cart_total if @storehouses.present?
  rescue Pagy::OverflowError
    redirect_to my_cart_path
  end

  def add_to_cart
    @product = Product.find_by(id: params[:product_id])
    @storehouse = @cart.storehouses.find_by(product_id: @product.id)
    if @product_avaliable >= params[:quantity].to_i
      add_new_or_update_exist_storehouse
      redirect_to @product, notice: t('notice.create.product_to_cart')
    elsif @product_avaliable.positive?
      params[:quantity] = @product_avaliable
      add_new_or_update_exist_storehouse
      redirect_to @product, alert: t('alert.update.part_add_to_cart')
    else
      redirect_to @product, alert: t('alert.update.not_add_to_cart')
    end
  end

  def remove_from_cart
    @storehouse.destroy
    @cart.destroy if @cart.storehouses.empty?
    redirect_to my_cart_path, notice: t('notice.destroy.product_from_cart')
  end

  def minus_one_item
    if @storehouse.quantity == 1
      remove_from_cart
    else
      new_quantity = @storehouse.quantity - 1
      @storehouse.update(quantity: new_quantity)
      redirect_to my_cart_path
    end
  end

  def plus_one_item
    if @product_avaliable.positive?
      new_quantity = @storehouse.quantity + 1
      @storehouse.update(quantity: new_quantity)
      redirect_to my_cart_path
    else
      redirect_to my_cart_path, alert: t('alert.update.plus_item_to_cart')
    end
  end

  private

  def check_product_avaliable
    @product_avaliable = Storehouse.count_avaliable_product(params[:product_id])
  end

  def set_storehouse
    @storehouse = Storehouse.find(params[:id])
  end

  def cart_total
    @cart_price = 0
    @cart_items = 0
    @discount_price = 0
    @storehouses.each do |storehouse|
      @cart_price += storehouse.quantity * storehouse.product.price
      @cart_items += storehouse.quantity
      @discount_price += storehouse.quantity * storehouse.product.price * @discount * 0.01
    end
    @price = @cart_price - @discount_price
  end

  def add_new_or_update_exist_storehouse
    if @storehouse.present?
      new_quantity = @storehouse.quantity + params[:quantity].to_i
      @storehouse.update(quantity: new_quantity)
    else
      new_storehouse = Storehouse.create(product_id: @product.id,
                                         operation_type: 'cart', quantity: params[:quantity])
      CartStorehouse.create(cart_id: @cart.id, storehouse_id: new_storehouse.id)
    end
    @cart.update(expiration_time: 24.hours.from_now)
  end
end
