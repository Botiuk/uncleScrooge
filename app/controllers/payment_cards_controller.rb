# frozen_string_literal: true

class PaymentCardsController < ApplicationController
  before_action :set_payment_card, only: %i[edit update destroy]
  authorize_resource

  def new
    @payment_card = PaymentCard.new
  end

  def edit; end

  def create
    @payment_card = PaymentCard.new(payment_card_params)
    if @payment_card.save
      redirect_to user_profile_path, notice: t('notice.create.payment_card')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @payment_card.update(payment_card_params)
      redirect_to user_profile_path, notice: t('notice.update.payment_card')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @payment_card.destroy
    redirect_to user_profile_path, notice: t('notice.destroy.payment_card')
  end

  private

  def set_payment_card
    @payment_card = PaymentCard.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to user_profile_path
  end

  def payment_card_params
    params.expect(payment_card: %i[card_number expiry_month expiry_year cvv user_id])
  end
end
