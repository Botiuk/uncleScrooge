# frozen_string_literal: true

class SalesController < ApplicationController
  before_action :set_sale, only: %i[edit update destroy]
  before_action :products_formhelper, only: %i[new create edit update]
  authorize_resource

  def index
    @pagy, @sales = pagy(Sale.includes(:product).order(updated_at: :desc), limit: 30)
  end

  def new
    @sale = Sale.new
  end

  def edit; end

  def create
    @sale = Sale.new(sale_params)
    if @sale.save
      redirect_to sales_path, notice: t('notice.create.sale')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @sale.update(sale_params)
      redirect_to sales_path, notice: t('notice.update.sale')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sale.destroy
    redirect_to sales_path, notice: t('notice.destroy.sale')
  end

  private

  def products_formhelper
    @products = Product.order(:name).pluck(:name, :id)
  end

  def set_sale
    @sale = Sale.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def sale_params
    params.expect(sale: %i[product_id percentage start_date end_date])
  end
end
