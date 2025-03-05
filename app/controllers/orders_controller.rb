# frozen_string_literal: true

class OrdersController < ApplicationController
  before_action :set_order, only: %i[edit update show]
  before_action :my_formhelper, only: %i[new create edit update]
  before_action :order_details, only: %i[show edit]
  authorize_resource

  def index
    @pagy, @orders = pagy(Order.order(created_at: :desc), limit: 30)
  end

  def show; end

  def new
    @order = Order.new
    @order.build_delivery_address_order
    @order.build_payment_card_order
  end

  def edit; end

  def create
    @order = Order.new(order_params)
    if @order.save
      create_joins_records
      redirect_to order_path(@order), notice: t('notice.create.order')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      update_join_storehouses if @order.order_status == 'sended'
      redirect_to order_path(@order), notice: t('notice.update.order')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def my_formhelper
    @delivery_addresses = DeliveryAddress.where(user_id: current_user.id).pluck(:address, :id)
    @payment_cards = PaymentCard.where(user_id: current_user.id).pluck(:card_number, :id)
  end

  def order_details
    @pagy, @order_items = pagy(OrderItem.includes(:storehouse).where(order_id: @order.id), limit: 30)
    @delivery_address = @order.delivery_address_order.delivery_address if @order.delivery_address_order.present?
  rescue Pagy::OverflowError
    redirect_to @order
  end

  def create_joins_records
    cart = Cart.includes(:storehouses).find(@order.cart_id)
    cart.update(cart_status: 'paided')
    cart.storehouses.each do |storehouse|
      storehouse.update(operation_type: 'paided')
      OrderItem.create(order_id: @order.id, storehouse_id: storehouse.id, product_price: storehouse.product.price)
    end
  end

  def update_join_storehouses
    order_items = OrderItem.includes(:storehouse).where(order_id: @order.id)
    order_items.each do |order_item|
      order_item.storehouse.update(operation_type: 'sended')
    end
  end

  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def order_params
    params.expect(order: [:order_status, :order_price, :cart_id, {
                    delivery_address_order_attributes: [:delivery_address_id],
                    payment_card_order_attributes: [:payment_card_id]
                  }])
  end
end
