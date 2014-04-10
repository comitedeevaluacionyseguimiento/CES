class AsignacioncomitesController < ApplicationController
  
  def index

    if params[:search]
      @searc = params[:search]
    else
      @searc = ""
    end 

    @asignacioncomites = Asignacioncomite.order("estado_id").search(params[:search]).page(params[:page]).per_page(2) 
  end

  def show
    @asignacioncomite = Asignacioncomite.find(params[:id])
    @queja = Queja.find(@asignacioncomite.quejaid)
  end

  def new
    @asignacioncomite = Asignacioncomite.new
  end

  def edit
    @asignacioncomite = Asignacioncomite.find(params[:id])
  end

  def create
    @asignacioncomite = Asignacioncomite.new(params[:asignacioncomite])
    @asignacioncomite.fecha = Asignacioncomite.splfecd(@asignacioncomite.created_at)
    render :action => :new unless @asignacioncomite.save
  end
  # == Este método me devuelbe un objeto con los aprendices que pertenecen a un programa
  def update_aprendices
    @programas = Programa.all
    @programaid = params[:programa_id]
    @aprendicesup = Asignacioncomite.where(:programa_id => @programaid, :estado_id => 4 )
    render :partial => "aprendicesco"
  end

  # == Este método me devuelbe un objeto con los programas que pertenecen a un coordinador
  def update_programa

    @aprendicesup = Queja.all
    @coordinadorid = params[:coordinador_id]
    @programas = Programa.where(:coordinador_id => @coordinadorid)

    render :partial => "programas"
  end
  # == Este método asigna la programación de los aprendices, crea un aprendiz y su historia 
  # *asigna los aprendices en una hora, sea uno o verios 
  # *crea los aprendices y les asigna una historia inicial con la queja y la programación para ellos 
  def asignar_hora
    @hora = params[:horas]
    @fcomiteid = params[:fcomite_id]
    @programaid = params[:programa_id]
    @ids = params[:ids].split(",").map {|s| s.to_i}
    @horas = @hora.split(",")
    @comites = Comite.where(:fcomite_id => @fcomiteid)
    
    

    i = 0
    @horas.each do |hora|
      if @ids[i] != 0
        @nombreasig = Asignacioncomite.find(@ids[i])
        @comite = @comites.find_by_hora(hora)
        if @comite then
          @comite.nombreapren = "#{@comite.nombreapren}, #{@nombreasig.nombres}"
          @comite.idsqueja = "#{@comite.idsqueja}, #{@nombreasig.quejaid}"
          @comite.save
          @quejas = Asignacioncomite.aprendiz_queja(@comite.idsqueja)

          @quejas.each do  |queja|
            @aprendiz_informacion = Queja.find(queja.id)
            @historia = Historia.find_by_queja_id(queja.id)
            @fcomite = Fcomite.find(@comite.fcomite_id)
            if !@historia
              @fecha = @fcomite.fecha
              @aprendiz = Aprendiz.create(:name => "#{@aprendiz_informacion.nombres}" + " #{@aprendiz_informacion.apellidos}",:tipo_documento_id => @aprendiz_informacion.tipo_documento_id,:num_document => @aprendiz_informacion.identificacion,:programa_id => @aprendiz_informacion.programa_id,:ficha => @aprendiz_informacion.ficha)
              Historia.create(:fecha => @fecha, :aprendiz_id => @aprendiz.id,:queja_id => @aprendiz_informacion.id,:comite_id => @comite.id)
            end
          end
        else
          @comite = Comite.create(:idsqueja => @nombreasig.quejaid, :hora => hora,:fcomite_id => @fcomiteid[0], :nombreapren => @nombreasig.nombres, :programa_id =>@programaid[0] , :ficha => @nombreasig.ficha,:asignacioncomite_id => @nombreasig.id, :quejaid => @nombreasig.quejaid)   
          @aprendiz_informacion = Queja.find(@comite.idsqueja)
          @aprendiz_existente = Aprendiz.find_by_num_document(@aprendiz_informacion.identificacion)
          @historia = Historia.find_by_queja_id(@aprendiz_informacion.id)
          @fcomite = Fcomite.find(@comite.fcomite_id)
          if !@historia
            
            if !@aprendiz_existente
              @fecha = @fcomite.fecha
              @aprendiz = Aprendiz.create(:name => "#{@aprendiz_informacion.nombres}" + "#{@aprendiz_informacion.apellidos}",:tipo_documento_id => @aprendiz_informacion.tipo_documento_id,:num_document => @aprendiz_informacion.identificacion,:programa_id => @aprendiz_informacion.programa_id,:ficha => @aprendiz_informacion.ficha)
              @historia = Historia.create(:fecha => @fecha,:aprendiz_id => @aprendiz.id,:queja_id => @aprendiz_informacion.id,:comite_id => @comite.id)
            else
              @fecha = @fcomite.fecha
              @historia = Historia.create(:fecha => @fecha,:aprendiz_id => @aprendiz_existente.id,:queja_id => @aprendiz_informacion.id,:comite_id => @comite.id)
            end
          end
        end
        @nombreasig.estado_id = 5
        @nombreasig.save
        i+=1
      end 
    end
    respond_to do |format|
      format.html { redirect_to asignar_path }
    end
   
  end

  # === Este metodo despliega una ventana lazybox, con el formulario para la observación
  def observacion

    @asignacioncomite = Asignacioncomite.find(params[:id])
    @observacion = params[:observaciones]
    @asignacioncomite.observaciones = @observacion
    @asignacioncomite.save

    redirect_to asignacioncomites_path
  end

  # === Este método despliega una ventana lazybox, para la asignación de los aprendices a la programación
  def asignar
    @fcomite_estado = Fcomite.where(:estado_id => 1)
    @programas = Programa.all
    @aprendicesup = Queja.all
  end

  def update
    @asignacioncomite = Asignacioncomite.find(params[:id])
    @asignacioncomite.fecha = Asignacioncomite.splfecd(@asignacioncomite.created_at)
    render :action => :edit unless @asignacioncomite.update_attributes(params[:asignacioncomite])
  end

  def destroy
    @asignacioncomite = Asignacioncomite.find(params[:id])
    @asignacioncomite.destroy
  end
end
