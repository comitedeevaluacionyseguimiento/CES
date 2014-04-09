class ProgramasController < ApplicationController
  
  helper_method :sort_column, :sort_direction

  before_filter :find_coordinador_and_programa

  def index
   
    if params[:search]
      @searc = params[:search]
    else
      @searc = ""
    end

    # == buscador
    @programas  = @coordinador.programas.order(sort_column + " " + sort_direction).search(params[:search]).page(params[:page]).per_page(5)
  end

 
  def show
    
  end


  def new
    @programa = Programa.new
  end


  def edit
    
  end


  def create
    @programa = @coordinador.programas.build(params[:programa])
    render :action => :new unless @programa.save
    @programas = Programa.all
  end


  def update
    render :action => :edit unless @programa.update_attributes(params[:programa])
  end


  def destroy
    @programa = Programa.find(params[:id])
    @programa.destroy
    @programas = Programa.all
  end

  # == ordenamiento
  private
  def sort_column
    Programa.column_names.include?(params[:sort]) ? params[:sort] : "descripcion"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  # == Metodo para buscar filtrar ids
  def find_coordinador_and_programa
    @centro = Centro.find(params[:centro_id])
    @coordinador = Coordinador.find(params[:coordinador_id])
    @programa = Programa.find(params[:id]) if params[:id]
  end
end
