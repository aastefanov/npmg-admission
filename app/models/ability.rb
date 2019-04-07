##
# Defines abilities
#
# Gives permissions for different user roles

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?
    can :access, :rails_admin
    can :read, :dashboard

    if user.is_parent?
      can :read, Exam
      can [:read, :edit, :create], Student, user_id: user.id

      can :edit, User, id: user.id

      can :read, [Region, City, School]
    end

    if user.has_role? :grader

    end

    if user.has_role? :declassifier

    end

    if user.has_role? :admin
      can :manage, :all
    end
  end
end