class CommitteesMembersController < ApplicationController
 
  def index
    @committees_members = CommitteeMembers.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @committees_members }
    end
  end

  def show
    @committee_members = CommitteeMembers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @committee_members }
    end
  end

  def new
    @committee_members = CommitteeMembers.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @committee_members }
    end
  end

  def edit
    @committee_members = CommitteeMembers.find(params[:id])
  end

  def create
    @committee_members = CommitteeMembers.new(params[:committee_members])

    respond_to do |format|
      if @committee_members.save
        format.html { redirect_to @committee_members, notice: 'Committee members was successfully created.' }
        format.json { render json: @committee_members, status: :created, location: @committee_members }
      else
        format.html { render action: "new" }
        format.json { render json: @committee_members.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @committee_members = CommitteeMembers.find(params[:id])

    respond_to do |format|
      if @committee_members.update_attributes(params[:committee_members])
        format.html { redirect_to @committee_members, notice: 'Committee members was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @committee_members.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @committee_members = CommitteeMembers.find(params[:id])
    @committee_members.destroy

    respond_to do |format|
      format.html { redirect_to committees_members_url }
      format.json { head :no_content }
    end
  end
end
