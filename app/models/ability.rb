# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can %i[read contacts], :main
    can :shop, Category
    can %i[show search], Product

    return if user.blank?
    #   can :read, :all
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
