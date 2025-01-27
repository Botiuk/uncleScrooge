# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can %i[read contacts], :main
    can :shop, Category
    can :read, Product

    return if user.blank?
    #   can :read, :all
    return unless user.admin?

    can :manage, Category
    can :manage, Product
    cannot :destroy, Product
  end
end
