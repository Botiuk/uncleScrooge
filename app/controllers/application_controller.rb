# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :find_root_categories
  before_action :active_cart

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_url, alert: t('alert.cancan_access_denied')
  end

  private

  def find_root_categories
    @navbar_root_categories = Category.where(ancestry: nil)
  end

  def active_cart
    return unless user_signed_in?

    @cart ||= Cart.where(user_id: current_user.id, cart_status: 'active')
                  .where('expiration_time > ?', 24.hours.ago).last

    return unless @cart.nil?

    @cart = Cart.create(user_id: current_user.id, cart_status: 'active')
  end

  def avaliable_products_hash
    @avaliable_products = []
    @products.each do |product|
      product_avaliable = Storehouse.count_avaliable_product(product.id)
      @avaliable_products << [product.id, product_avaliable] if product_avaliable.positive?
    end
    @avaliable_products = @avaliable_products.to_h
  end
end
