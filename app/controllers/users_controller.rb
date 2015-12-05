class UsersController < ApplicationController
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @users = User.all(:all, :order => "id ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    if cannot? :manage, User
      params[:user][:roles] = ''
    end

    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if cannot? :manage, User
      params[:user][:roles] = @user[:roles]
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to root_url, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # GET /users/1/activate
  # GET /users/1/activate.json
  def activate
    @user = User.find(params[:id])
 
   respond_to do |format|
      if @user.update_attributes(:roles => :user)
        format.html { redirect_to users_url, notice: 'User was successfully activated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users/1/makeadmin
  # POST /users/1/makeadmin.json
  def makeadmin
    @user = User.find(params[:id])
 
   respond_to do |format|
      if @user.update_attributes(:roles => @user.roles.to_s + ", admin")
        format.html { redirect_to users_url, notice: 'User was successfully made admin.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
