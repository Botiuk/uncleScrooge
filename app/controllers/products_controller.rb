# frozen_string_literal: true

class ProductsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[show search]
  before_action :set_product, only: %i[edit update show]
  before_action :categories_formhelper, only: %i[new create edit update]
  authorize_resource

  def index
    @pagy, @products = pagy(Product.order(:price), limit: 30)
  rescue Pagy::OverflowError
    redirect_to products_path(page: 1)
  end

  def show
    @category = Category.find(@product.category_id)
    product_input = Storehouse.count_product_by_operation_type(@product.id, 'input')
    product_output = Storehouse.count_product_by_operation_type(@product.id, %w[cart paided])
    @product_avaliable = product_input - product_output
  end

  def new
    @product = Product.new(category_id: params[:category_id])
  end

  def edit; end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to product_path(@product), notice: t('notice.create.product')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      attachments = ActiveStorage::Attachment.where(id: params[:deleted_photo_ids])
      attachments.map(&:purge)

      redirect_to product_path(@product), notice: t('notice.update.product')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def search
    if params[:product_name].blank?
      redirect_to root_path, alert: t('alert.search.product')
    else
      @pagy, @products = pagy(Product.where('lower(name) LIKE ?', "%#{params[:product_name].downcase}%")
                                     .order(:price), limit: 20)
      @search_param = params[:product_name]
    end
  rescue Pagy::OverflowError
    redirect_to root_path
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
