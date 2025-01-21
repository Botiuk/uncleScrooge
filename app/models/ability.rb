# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can %i[read contacts], :main
    can :read, Category

    return if user.blank?
    #   can :read, :all
    return unless user.admin?

    can :manage, Category
  end
end
