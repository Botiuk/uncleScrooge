# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can %i[read contacts], :main
    can :shop, Category
    can %i[show search], Product

    return if user.blank?

    can %i[show destroy add_to_cart remove_from_cart minus_one_item plus_one_item], Cart do |cart|
      cart.user_id == user.id
    end

    return unless user.admin?

    can :manage, Category
    can :manage, Product
    cannot :destroy, Product
    can %i[index create search], Storehouse
    can %i[update destroy], Storehouse do |storehouse|
      storehouse.operation_type == 'input'
    end
  end
end
