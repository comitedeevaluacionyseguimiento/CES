class RolesController < ApplicationController
  
  def index
    @roles = Role.all
  end

  def show
    @role = Role.find(params[:role_id])
  end

  def new
    @role = Role.new
  end

  def edit
    @role = Role.find(params[:id])
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      render :show
    else
      renser :new
    end    
  end

  def update
    @role = Role.find(params[:id])
    @role.save
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
  end
end
