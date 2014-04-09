class FcomitesController < ApplicationController

  def index
    
    if params[:search]
      @searc = params[:search]
    else
      @searc = ""
    end

    @fcomites = Fcomite.order("estado_id").search(params[:search]).page(params[:page]).per_page(5)
  end

  def show
    @fcomite = Fcomite.find(params[:id])
  end

  def new
    @fcomite = Fcomite.new
    @aprendices = Asignacioncomite.all
  end

  def edit
    @fcomite = Fcomite.find(params[:id])
  end

  def create
    @fcomite = Fcomite.new(params[:fcomite])
    @fcomite.tipo = params[:tipo]
    @fcomite.estado_id = 1
    render :action => :new unless @fcomite.save
    redirect_to fcomites_path
    @fcomites = Fcomite.all
  end

  def update_aprendices

    @aprendices = Asignacioncomite.where(:programa_id => params[:programa_id])
    render :partial => "aprendices", :object => @aprendices
  end

  def update
    @fcomite = Fcomite.find(params[:id])
    @fcomite.tipo = params[:tipo]
    render :action => :edit unless @fcomite.update_attributes(params[:fcomite])
  end

  def destroy
    @fcomite = Fcomite.find(params[:id])
    Comite.where(:fcomite_id => @fcomite.id).destroy_all#destruir a los hijos 
    @fcomite.destroy
  end
  
end
