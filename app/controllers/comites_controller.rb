# encoding: UTF-8
class ComitesController < ApplicationController

  helper_method :sort_column, :sort_direction

  before_filter :find_fcomite_and_comite, :except => [:envio_email, :crear_acta,:cracta,:emails_comite]

  def index
   
    if params[:search]
      @searc = params[:search]
    else
      @searc = ""
    end

    #buscador
    @comites  = @fcomite.comites.order(sort_column + " " + sort_direction).search(params[:search]).page(params[:page]).per_page(5)
    #esta variable trae todos los registros para el pdf
    @a = @fcomite.comites.order("hora")
    @fcomite = Fcomite.find(params[:fcomite_id])
    output = ComiteList.new(@a,@fcomite,view_context) # Aquí instancio el documento pdf
  
    respond_to do |format|
      format.pdf{
       send_data output.render, :filename => "programacion_comite.pdf", :type => "application/pdf", 
        :disposition => "inline" # este parámetro permite ver el documento pdf en linea.
      }
      format.html #{ render :text => "<h1>Use .pdf</h1>".html_safe }
      format.json { render json: @comites  }
    end

  end
  
  # === Este método es utilizado  para el pdf de citación 
  def show

   
    if params[:format] == "pdf"
      @queja = Queja.find(params[:qid])
      @fechaes, @año = Comite.fechaes
      output = CitacionList.new(@queja,@comite,@fechaes,@año,view_context) # Aquí instancio el documento pdf
      respond_to do |format|
        format.pdf{
          send_data output.render, :filename => "citacion.pdf", :type => "application/pdf", 
          :disposition => "inline" # este parámetro permite ver el documento pdf en linea.
        }
      end
    end
   
  end


  def new
    @comite = Comite.new
  end

 
  def edit
   
  end
  

  def create
    @comite = @fcomite.comites.build(params[:comite])
    render :action => :new unless @comite.save
    @comites = Comite.all
  end

  # === Método para el envío de email con el mailer de rails, para el aprendiz y los usuarios del  comite
  def envio_email
    #datos para envio de email a los miembros del comite y variables para anexar el pdf a el email
    @fcomite = Fcomite.find(params[:fcomite_id])
    @comitespdf = Comite.where(:fcomite_id => params[:fcomite_id])
    #email miembros comite
    @comitespdf.each do |detalle_comite|
      quejaid =  detalle_comite.quejaid
      @comitea = Comite.find_by_quejaid(quejaid)
      @queja = Queja.find(quejaid)
      ComiteMailer.citacion_aprendiz(@queja,@comitea,"Citacion Comite Evaluacion y Seguimiento").deliver

      @usercomite = Usercomite.find_by_comite_id(@comitea.id)
      @emailusercom = Comite.emails(@usercomite.emails)
      ComiteMailer.usercomite_programacion(@fcomite, @comitespdf, @emailusercom, "notificacion de la queja" ).deliver
    end
    respond_to do |format|
      format.html { redirect_to fcomite_comites_path(@fcomite.id) }
      format.js { render 'comites/envio_email' }
    end
  end


  def update
    render :action => :edit unless @comite.update_attributes(params[:comite])
  end


  def destroy
    @comite = Comite.find(params[:id])
    @comite.destroy
    @comites = Comite.all
  end
 # == En este metodo se recuperan los nombres y los emails de los usuarios en la db para mostrarlos en el formulario de asignación de usuarios
  def emails_comite
    @committee_members_id = params[:committee_members_id]
    @usersname = params[:names]
    @instructorid = params[:instructor_id]
    @email = params[:email]
    if @committee_members_id != "" and @email == ""
      @committee_member = CommitteeMembers.find(@committee_members_id)
      @names  = @committee_member.name 
      @emails = @committee_member.email
    elsif @email and @committee_members_id != ""
      @committee_member = CommitteeMembers.find(@committee_members_id)
      @names  =  @usersname + ",#{@committee_member.name}"
      @emails =  @email + ",#{@committee_member.email}"
    end

    if @instructorid != "" and @email == ""
      @instructor = Instructor.find(@instructorid)
      @names  = @instructor.nombres 
      @emails = @instructor.email
    elsif @email and  @instructorid != ""
      @instructor = Instructor.find(@instructorid)
      @names  =  @usersname + ",#{@instructor.nombres}"
      @emails =  @email + ",#{@instructor.email}"
    end

    respond_to do |format|
      format.js { render 'emails' } #cal_cost.js.erb
    end
    
  end

  # == En este metodo se guardan los registros de los usuarios, en el comite al que fueron asignados
  def asignar_userc
   
    @fcomite = Fcomite.find(params[:fcomite_id])
    @comite_id = params[:comite_id]
    @nombres = params[:names]
    @emails = params[:emails]
    Usercomite.create(:nombre => @nombres, :emails => @emails,:comite_id => @comite_id)
    @comites = Comite.all
    redirect_to fcomite_comites_path(@fcomite.id)
  end

  # === En este metodo se crea el acta, para cada hora asignada 
  def crear_acta
    @comite_id = params[:comite_id]
    @hora_inicio = params[:hora_inicio]
    @hora_final = params[:hora_terminacion]
    @objetivo_reunion = params[:objetivo_de_la_reunion]
    @desarrollo_reunion = params[:desarrollo_reunion]
    @conclusiones = params[:conclusiones]
    @subdirector = params[:subdirector]
    @comite = Comite.find(@comite_id)
    @fcomite = Fcomite.find(@comite.fcomite_id)
    @fecha_creacion = Time.now.strftime("%Y-%m-%d")

    @num_acta = Acta.numero_acta
    @acta = Acta.create(:num_acta => @num_acta, :fecha_creacion => @fecha_creacion,:subdirector => @subdirector, :configuracion_id => 1, :fecha => @fcomite.fecha,:comite_id => @comite_id, :hora_inicio => @hora_inicio, :hora_terminacion => @hora_final, :objetivo_de_la_reunion => @objetivo_reunion, :desarrollo_reunion => @desarrollo_reunion, :conclusiones => @conclusiones)
    Comite.acta_historia(@acta)

    redirect_to fcomite_comites_path(@fcomite.id)
  end
  
  #ordenamiento
  private
  def sort_column
    Comite.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def find_fcomite_and_comite
    @fcomite = Fcomite.find(params[:fcomite_id])
    @comite = Comite.find(params[:id]) if params[:id]
  end
end
