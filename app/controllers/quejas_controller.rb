# encoding: UTF-8
class QuejasController < ApplicationController
  
  helper_method :sort_column, :sort_direction
  # == El buscador esta condicionado para que mustre las quejas por usuario tipo  instructor
  def index
    
    if params[:search]
      @searc = params[:search]
    else
      @searc = ""
    end

    #buscador
    if Queja.has_role(current_user.id) == "instructor"
      @quejas  = Queja.indes(current_user.id).order(sort_column + " " + sort_direction).search(params[:search]).page(params[:page]).per_page(5)
      @estadoquejas = @quejas.where(:estado_id => 1)
      @estadoencomite =  @quejas.where(:estado_id => 2)
      @quejacorreccion =  @quejas.where(:estado_id => 3)
    else

      @quejas  = Queja.order(sort_column + " " + sort_direction).search(params[:search]).page(params[:page]).per_page(5)
      @estadoquejas = Queja.where(:estado_id => 1) 
      @estadoencomite =  Queja.where(:estado_id => 2)
      @quejacorreccion =  Queja.where(:estado_id => 3)
    end
    #esta variable trae todos los registros para el pdf
    @a= Queja.all 
  end

  # == método para descargar evidencia
  def download
    @queja = Queja.find(params[:id])
    send_file(@queja.evidencia.path)
  end 


  def show
    @queja = Queja.find(params[:id])
    
    if params[:format] == "pdf"
      output = QuejaList.new(@queja,view_context) # Aquí instancio el documento pdf
      respond_to do |format|
        format.pdf{
          send_data output.render, :filename => "quejaList.pdf", :type => "application/pdf", 
          :disposition => "inline" # este parámetro permite ver el documento pdf en linea.
        }
      end
    end
  end

  
  def new
    @queja = Queja.new
   
    @programas = Programa.all
  end

 
  def edit
    @queja = Queja.find(params[:id])
  end

  def create
    @queja = Queja.new(params[:queja])
    @queja.falta = params[:falta]
    @queja.estado_id =  1
    @queja.userid = current_user.id

    if @queja.save 
      envio_email
    else
      render :action => :new unless @queja.save
    end  
  
  end

  # == Este método guarda la información en la tabla de Asignacioncomite 
  def asigna
    @queja = Queja.find(params[:id])
    Asignacioncomite.create(:estado_id => 4, :nombres => @queja.nombres, :apellidos => @queja.apellidos, :programa_id => @queja.programa.id, :ficha => @queja.ficha, :quejaid => @queja.id)
    @queja.estado_id = 2
    @queja.save
  end

  # == Este método recoje la información para enviar el correo en  caso de corrección 
  def cuerpo_correo_correccion
    @queja = Queja.find(params[:id])
    @user = User.find(@queja.userid)
  end

  # == Este método envia un correo al instructor, para que corrija la queja  
  def corregir
    @queja = Queja.find(params[:queja])
    @useremail = params[:email]
    @bodyemail = params[:body]
    QuejaMailer.correcion_queja(@bodyemail,@queja,@useremail,"Corrección de la queja presentada" ).deliver
    @queja.estado_id = 3 
    @queja.save
    redirect_to quejas_path
  end

  def update
    @queja = Queja.find(params[:id])
    render :action => :edit unless @queja.update_attributes(params[:queja])
    @queja.estado_id =  1
    @queja.save
  end
   
  
  def destroy
    @queja = Queja.find(params[:id])
    @queja.destroy
    @quejas = Queja.all
  end

  
  # == Metodo que envia un correo al instructor que creo la queja y al coordinador del programa
  def envio_email
    @desticoor = @queja.programa.coordinador.id
    @coordinadorp = Coordinador.find(@desticoor)
    
    QuejaMailer.registro_queja_coordinador(@queja, @coordinadorp,"Notificación de Queja").deliver
    QuejaMailer.registro_queja_instructor(@queja,current_user.email, "Notificación de Queja" ).deliver
  end
  
 
  private
  # == ordenamiento
  def sort_column
    Queja.column_names.include?(params[:sort]) ? params[:sort] : "estado_id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
    
