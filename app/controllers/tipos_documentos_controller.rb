 class TiposDocumentosController < ApplicationController

  helper_method :sort_column, :sort_direction
  
  def index
    
    if params[:search]
      @searc = params[:search]
    else
      @searc = ""
    end
    #buscador
    @tipos_documentos  = TipoDocumento.order(sort_column + " " + sort_direction).search(params[:search]).page(params[:page]).per_page(5)
    
  end

  
  def show
    @tipo_documento = TipoDocumento.find(params[:id])
  end

  
  def new
    @tipo_documento = TipoDocumento.new
  end

  
  def edit
    @tipo_documento = TipoDocumento.find(params[:id])
  end

  
  def create
    @tipo_documento = TipoDocumento.new(params[:tipo_documento])
    render :action => :new unless @tipo_documento.save
    @tipos_documentos = TipoDocumento.all
  end

  
  def update
    @tipo_documento = TipoDocumento.find(params[:id])
    render :action => :edit unless @tipo_documento.update_attributes(params[:tipo_documento])
  end

 
  def destroy
    @tipo_documento = TipoDocumento.find(params[:id])
    @tipo_documento.destroy
    @tipos_documentos = TipoDocumento.all
  end
  
  #ordenamiento
  private
  def sort_column
    TipoDocumento.column_names.include?(params[:sort]) ? params[:sort] : "descripcion"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
