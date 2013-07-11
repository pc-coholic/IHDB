class Ability
  include CanCan::Ability

  def initialize(user)
  	user ||= User.new # guest user
  	
  	if user.has_role? :admin
  		can :manage, :all
  	else
    	can :create, [:user_session, User]
    end
  end
end
