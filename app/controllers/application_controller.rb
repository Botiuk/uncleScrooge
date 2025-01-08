# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to root_url, alert: t('alert.cancan_access_denied')
  end
end
