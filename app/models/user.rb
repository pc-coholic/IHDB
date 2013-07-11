class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_reader
  attr_accessible :crypted_password, :current_login_at, :current_login_ip, :email, :failed_login_count, :last_login_at, :last_login_ip, :last_request_at, :login_count, :name, :password_salt, :perishable_token, :persistence_token, :roles, :username, :password, :password_confirmation

  def has_role?(role)
  	roles.to_s.include? role.to_s
  end
end
