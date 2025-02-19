# frozen_string_literal: true

class DeliveryAddressesController < ApplicationController
  before_action :set_delivery_address, only: %i[edit update destroy]
  authorize_resource

  def new
    @delivery_address = DeliveryAddress.new
  end

  def edit; end

  def create
    @delivery_address = DeliveryAddress.new(delivery_address_params)
    if @delivery_address.save
      redirect_to user_profile_path, notice: t('notice.create.delivery_address')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @delivery_address.update(delivery_address_params)
      redirect_to user_profile_path, notice: t('notice.update.delivery_address')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @delivery_address.destroy
    redirect_to user_profile_path, notice: t('notice.destroy.delivery_address')
  end

  private

  def set_delivery_address
    @delivery_address = DeliveryAddress.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to user_profile_path
  end

  def delivery_address_params
    params.expect(delivery_address: %i[post_service country locality address personal_name phone user_id])
  end
end
