# encoding: UTF-8 

class ActasController < ApplicationController
  
  helper_method :sort_column, :sort_direction

  def index
    if params[:search]
      @searc = params[:search]
    else
      @searc = ""
    end
    
    # == Buscador
    @actas  = Acta.order(sort_column + " " + sort_direction).search(params[:search]).page(params[:page]).per_page(5)

  end

 
  def show 
    @acta = Acta.find(params[:id])
    @nombres, @ficha,  @plural_singular = Acta.nombres_pdf_acta(@acta)
    if params[:format] == "pdf"
      output = ActaList.new(@nombres,@ficha,@plural_singular,@acta,view_context) # Aquí instancio el documento pdf
      respond_to do |format|
        format.pdf{
          send_data output.render, :filename => "Acta.pdf", :type => "application/pdf", 
          :disposition => "inline" # este parámetro permite ver el documento pdf en linea.
        }
      end
    end
  end

  
  def new
    @acta = Acta.new
  end


  def edit
    @acta = Acta.find(params[:id])
  end


  def create
    @acta = Acta.new(params[:acta])
    render :action => :new unless @acta.save
    @actas = Acta.all
  end


  def update
    @acta = Acta.find(params[:id])
    render :action => :edit unless @acta.update_attributes(params[:acta])
  end


  def destroy
    @acta = Acta.find(params[:id])
    @acta.destroy
    @actas = Acta.all
  end

  # == Método para el pdf de condicionamiento
  # *El método "fechaes" es llamado desde el modelo de comite y retorna la fecha y el año actual 
  def pdf_condicionamiento
    @acta = Acta.find(params[:id])
    @fechaes, @año = Comite.fechaes
    @queja = Queja.find(params[:idq])
    if params[:format] == "pdf"
      output = Condicionamiento.new(@acta,@queja,@fechaes, @año,view_context) # Aquí instancio el documento pdf
      respond_to do |format|
        format.pdf{
          send_data output.render, :filename => "Condicionamiento_de_matricula.pdf", :type => "application/pdf", 
          :disposition => "inline" # este parámetro permite ver el documento pdf en linea.
        }
      end
    end
  end

  # ===  Método para el pdf de cancelacióon 
  def pdf_cancelacion
      @acta = Acta.find(params[:id])#recupero el acta
      @configuracion = Configuracion.find(@acta.configuracion_id)#busco la configuración para el acta
      @fechaes, @año = Comite.fechaes
      @queja = Queja.find(params[:idq])
      output = Cancelacion.new(@acta,@configuracion,@queja,@fechaes, @año,view_context) # Aquí instancio el documento pdf
      respond_to do |format|
        format.pdf{
          send_data output.render, :filename => "Cancelacion de matricula.pdf", :type => "application/pdf", 
          :disposition => "inline" # este parámetro permite ver el documento pdf en linea.
        }

      end
  end

  # ===  Método para el pdf de llamado_atencion 
  def pdf_llamado_atencion
    @acta = Acta.find(params[:id])
    @fechaes, @año = Comite.fechaes
    @fecha_comite = Acta.fechaes(@acta.comite.fcomite.fecha)
    @historia = Historia.find_by_queja_id(params[:idq])
    if params[:format] == "pdf"
      output = LlamadoAtencion.new(@historia,@fechaes,@fecha_comite,@año,view_context) # Aquí instancio el documento pdf
      respond_to do |format|
        format.pdf{
          send_data output.render, :filename => "Llamado de Atencion.pdf", :type => "application/pdf", 
          :disposition => "inline" # este parámetro permite ver el documento pdf en linea.
        }
      end
    end
  end

  # === Método que guarda el llamado de atención
  def asignar_llamado_atencion
    @queja_id         = params[:queja_id]
    @llamado_atencion = params[:llamado_de_atencion]
    @update_historia = Acta.llamado_atencion(@queja_id,@llamado_atencion)
    redirect_to :actas, notice: 'Se a creado El llamado de atencion'
  end
  #  * Este método despliega el form para editar el llamado de atención
  def llamado_atencion
    acta    = params[:acta_id]
    @quejas = Acta.quejas_acta(acta)
  end

  
  # == Ordenamiento
  private
  def sort_column
    Acta.column_names.include?(params[:sort]) ? params[:sort] : "fecha"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
