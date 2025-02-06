# frozen_string_literal: true

class StorehousesController < ApplicationController
  before_action :set_storehouse, only: %i[edit update destroy]
  before_action :products_formhelper, only: %i[new create edit update]
  authorize_resource

  def index
    @pagy, @storehouses = pagy(Storehouse.includes(:product).order(updated_at: :desc), limit: 30)
  end

  def new
    @storehouse = Storehouse.new
  end

  def edit; end

  def create
    @storehouse = Storehouse.new(storehouse_params)
    if @storehouse.save
      redirect_to storehouses_path, notice: t('notice.create.storehouse')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @storehouse.update(storehouse_params)
      redirect_to storehouses_path, notice: t('notice.update.storehouse')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @storehouse.destroy
    redirect_to storehouses_path, notice: t('notice.destroy.storehouse')
  end

  def search
    if params[:product_id].blank?
      redirect_to root_path
    else
      @pagy, @storehouses = pagy(Storehouse.where(product_id: params[:product_id]).order(updated_at: :desc), limit: 30)
      @product = Product.find(params[:product_id])
      count_product(params[:product_id])
    end
  rescue Pagy::OverflowError
    redirect_to root_path
  end

  private

  def products_formhelper
    @products = Product.order(:name).pluck(:name, :id)
  end

  def count_product(product_id)
    @product_input = Storehouse.count_product_by_operation_type(product_id, 'input')
    @product_cart = Storehouse.count_product_by_operation_type(product_id, 'cart')
    @product_paided = Storehouse.count_product_by_operation_type(product_id, 'paided')
  end

  def set_storehouse
    @storehouse = Storehouse.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def storehouse_params
    params.expect(storehouse: %i[operation_type product_id quantity])
  end
end
