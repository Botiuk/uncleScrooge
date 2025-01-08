# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :main

    # return if user.blank?
    #   can :read, :all
    # return unless user.admin?
    #   can :manage, :all
  end
end
