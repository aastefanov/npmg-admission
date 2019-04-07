##
# Defines abilities
#
# Gives permissions for different user roles

class Ability
  include CanCan::Ability

  ##
  # Initializes ability classes
  #
  # @param user [User] The user to assign permissions to
  # @return [void]
  def initialize(user)
    return unless user.present?

    initialize_parent_permissions user

    initialize_admin_permissions user
  end

  ##
  # Gives permissions to parents
  #
  # They can read the information needed for student registration
  # They can manage their own students
  #
  # @param user [User] The parent to assign permissions to
  # @return [void]
  def initialize_parent_permissions(user)
    if user.is_parent?

      can :read, Exam
      can [:read, :edit, :create], Student, user_id: user.id
      can :edit, User, id: user.id
      can :read, [Region, City, School]
    end

  end

  ##
  # Gives permissions to admins
  #
  # Admins have access to RailsAdmin and full permissions to all models
  #
  # @param user [User] The admin to assign permissions to
  # @return [void]
  def initialize_admin_permissions(user)
    if user.has_role? :admin

      can :access, :rails_admin
      can :read, :dashboard
      can :manage, :all
    end
  end
end