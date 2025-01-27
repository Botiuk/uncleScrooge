# frozen_string_literal: true

class CategoriesController < ApplicationController
  skip_before_action :authenticate_user!, only: :shop
  before_action :set_category, only: %i[edit update show destroy shop]
  authorize_resource

  def index
    @categories = Category.where(ancestry: nil).order(:name)
  end

  def show; end

  def new
    @category = Category.new(parent_id: params[:parent_id])
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_url(@category), notice: t('notice.create.category')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to category_url(@category), notice: t('notice.update.category')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.has_children?
      redirect_to category_url(@category), alert: t('alert.destroy.category'), status: :unprocessable_entity
    else
      @category.destroy
      redirect_to categories_url, notice: t('notice.destroy.category')
    end
  end

  def shop
    @pagy, @products = pagy(Product.where(category_id: @category.descendant_ids)
                                   .or(Product.where(category_id: @category.id)).order(:price), limit: 20)
  end

  private

  def set_category
    @category = Category.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def category_params
    params.expect(category: %i[name avatar description parent_id])
  end
end
