class CentrosController < ApplicationController

  helper_method :sort_column, :sort_direction
 
  def index
    
    if params[:search]
      @searc = params[:search]
    else
      @searc = ""
    end

    # == buscador
    @centros  = Centro.order(sort_column + " " + sort_direction).search(params[:search]).page(params[:page]).per_page(5)
  end


  def show
    @centro = Centro.find(params[:id])
  end


  def new
    @centro = Centro.new
  end


  def edit
    @centro = Centro.find(params[:id])
  end


  def create
    @centro = Centro.new(params[:centro])
    render :action => :new unless @centro.save
    @centros = Centro.all
  end


  def update
    @centro = Centro.find(params[:id])
    render :action => :edit unless @centro.update_attributes(params[:centro])
  end


  def destroy
    @centro = Centro.find(params[:id])
    @centro.destroy
    @centros = Cargo.all
  end
  
  #ordenamiento
  private
  def sort_column
    Centro.column_names.include?(params[:sort]) ? params[:sort] : "nombre"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
