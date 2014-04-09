#cancan
class Ability
  # == Esta linea incluye la libreria cancan que hereda de hability
  include CanCan::Ability

  # == En este método se definen las capacidades  de los usuarios
  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
      elsif user.has_role? :coordinador
        can :manage, :all
      elsif user.has_role? :Instructor
        can  :manage, [Queja]
    end
  end
end
