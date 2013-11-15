class Ability
  include CanCan::Ability

  def initialize(user)
  	user ||= User.new # guest user
  	
  	if user.has_role? :admin
      # Can do everything
  		can :manage, :all

    elsif user.has_role? :user
      # Can Login and Logout
      can :create, :user_session
      can :destroy, :user_session

      # Can create, update and read Entries
      # and mark them as read
      can :create, Entry
      can :update, Entry
      can :read, Entry
      can :markasread, Entry

      # Can update own profile
      can :create, User
      can :update, User, :id => user.id
      
  	else
      # Can Login
      can :create, :user_session

      # Can create new Users and update profile
      can :create, User
    end
  end
end
