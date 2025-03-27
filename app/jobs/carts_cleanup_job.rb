# frozen_string_literal: true

class CartsCleanupJob < ApplicationJob
  queue_as :default

  def perform
    old_carts = Cart.includes(:storehouses).where(cart_status: 'active', expiration_time: ...DateTime.current)
    old_carts.each do |old_cart|
      old_cart.storehouses.each(&:destroy)
    end
    old_carts.each(&:destroy)
  end
end
