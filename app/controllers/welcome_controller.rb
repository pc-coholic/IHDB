class WelcomeController < ApplicationController
  def index
  	if can? :read, Entry
  		redirect_to entries_url
  	end
  end
end
