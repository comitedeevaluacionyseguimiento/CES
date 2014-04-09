class Acta < ActiveRecord::Base
	belongs_to :comite
	has_many :configuraciones 
    # == Atributos 
    attr_accessible :fecha_creacion, :num_acta, :llamado_atencion,:subdirector,:configuracion_id, :comite_id, :conclusiones, :desarrollo_reunion, :fecha, :hora_inicio, :hora_terminacion, :objetivo_de_la_reunion
    
    # == buscador, recibe el argumento ingresado en la vista y realiza la busqueda 
    def self.search(search)
		where('fecha like ?', "%#{search}%")
	end

	# == Este método recibe el id de acta y saca los nombres para el pdf de acta 
	def self.nombres_pdf_acta(acta)
		@acta = Acta.find(acta)
		idsq = @acta.comite.idsqueja.split(",")
		@nombres = ""
		if idsq.length > 1
			idsq.each do |id|
				@queja = Queja.find(id)
				@nombres += "- #{@queja.nombres} #{@queja.apellidos}, con  #{@queja.tipo_documento.sigla}. #{@queja.identificacion} \n"
				@ficha = @queja.ficha
			end
			@plural_singular = "de los(as) aprendices "
			return @nombres, @ficha, @plural_singular
		else
			@queja = Queja.find(idsq[0])
			@nombre = "- #{@queja.nombres} #{@queja.apellidos}, con  #{@queja.tipo_documento.sigla}. #{@queja.identificacion}"
			@ficha = @queja.ficha
			@plural_singular = "del aprendiz "
			return @nombre, @ficha, @plural_singular
		end
	end

	# == Este método recibe la fecha del comite y organiza el formato de esta manera => "2014/Marzo/05"
	def self.fechaes(fecha_comite)
	    fecha = fecha_comite.to_time
	    @mes = fecha.month
	    case @mes
	      when 1
	        @m = "Enero"
	      when 2
	        @m = "Febrero"
	      when 3
	        @m = "Marzo"
	      when 4
	        @m = "Abril"
	      when 5
	        @m = "Mayo"
	      when 6
	        @m = "Junio"
	      when 7
	        @m = "Julio"
	      when 8
	        @m = "Agosto"
	      when 9
	        @m = "Septiembre"
	      when 10
	        @m = "Octubre"
	      when 11
	        @m = "Noviembre"
	      when 12
	        @m = "Diciembre"
	    end
	    @fecha_comite = fecha.strftime("%d/#{@m}/%Y")
	    return @fecha_comite
    end

    # == Este método genera un número secuencial y lo reinicia por año 
    def self.numero_acta

    	@fecha_actual = Time.now
    	año_actual   = @fecha_actual.year

    	@ultima_acta = Acta.last
    	if @ultima_acta
    		fecha    = @ultima_acta.fecha_creacion.to_time
	    	año_acta = fecha.year

	    	if  @ultima_acta.num_acta == "" or año_acta != año_actual
	    		@num_acta = "01"
	       	else
	       		num_acta = num_acta.to_i
	       		acta = Acta.last.num_acta
	       		@num_acta = acta.to_i + 1
	       		if @num_acta < 10
	       			return "0#{@num_acta}"
	       		end
	       	end
	    else
	    	@num_acta = "01"
    	end
    	return "#{@num_acta}"
    end

    # == Este método recibe al id de acta y retorna un objeto con las queja, que se recuperan del campo de comite idsqueja
    def self.quejas_acta(acta)
    	@acta = Acta.find(acta)
    	@comite = Comite.find(@acta.comite_id)
    	quejasid = @comite.idsqueja.split(", ")
    	@quejas = []

    	quejasid.each do |id|
    		queja = Queja.find(id)
    		@quejas << queja
    	end
    	return @quejas
    end

    # Este método recibe el id de queja, y el string llamado_atencion, con esto consulta la historia por queja_id y guarda el valor del string en historia
    def self.llamado_atencion(queja_id,llamado_atencion)
    	@historia = Historia.find_by_queja_id(queja_id)
    	@historia.llamada_atencion = llamado_atencion
    	@histori_update = @historia.save
    	return @histori_update
    end
end

