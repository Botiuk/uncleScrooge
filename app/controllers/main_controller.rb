# frozen_string_literal: true

class MainController < ApplicationController
  skip_before_action :authenticate_user!
  authorize_resource class: false

  def index
    last_product_ids = Storehouse.where(operation_type: 'input').order(updated_at: :desc).limit(12).pluck(:product_id)
    @products = Product.where(id: last_product_ids)
    avaliable_products_hash
  end

  def contacts; end
end
