# frozen_string_literal: true

class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_product, only: %i[edit update show]
  before_action :categories_formhelper, only: %i[new create edit update]
  authorize_resource

  def index
    @pagy, @products = pagy(Product.order(:price), limit: 30)
  end

  def show
    @category = Category.find(@product.category_id)
  end

  def new
    @product = Product.new(category_id: params[:category_id])
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_url(@product), notice: t('notice.create.product')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      attachments = ActiveStorage::Attachment.where(id: params[:deleted_photo_ids])
      attachments.map(&:purge)

      redirect_to product_url(@product), notice: t('notice.update.product')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def categories_formhelper
    @categories = Category.formhelper
  end

  def set_product
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def product_params
    params.expect(product: [:name, :price, :description, :category_id, { photos: [] }])
  end
end
