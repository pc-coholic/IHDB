class EntriesController < ApplicationController
  load_and_authorize_resource
  # GET /entries
  # GET /entries.json
  def index
    #@entries = Entry.all
    #@entries = Entry.find(:all, :order => "updated_at DESC")
    @entries = Entry.search(params[:search])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.json
  def create
    if cannot? :manage, Entry
      params[:entry][:important] = ''
    end

    @entry = Entry.new(params[:entry])

    respond_to do |format|
      if @entry.save
    	@entry.mark_as_read! :for => current_user

        format.html { redirect_to entries_url, notice: 'Entry was successfully created.' }
        format.json { render json: @entry, status: :created, location: @entry }
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])

    if cannot? :manage, Entry
      params[:entry][:important] = @entry[:important]
    end

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
    	@entry.mark_as_read! :for => current_user

        format.html { redirect_to entries_url, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end

  # GET /entries/1/markasread
  # GET /entries/1/markasread.json
  def markasread
    @entry = Entry.find(params[:id])
    @entry.mark_as_read! :for => current_user
    
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully marked as read.' }
      format.json { head :no_content }
    end
  end
end
