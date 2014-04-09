class Fcomite < ActiveRecord::Base
	has_many :comites, :dependent => :destroy
	belongs_to :estado
    attr_accessible :fecha, :lugar, :tipo, :estado_id

	#validations
	validates :fecha, presence: true
	validates :lugar, presence: true
	validates :tipo, presence: true

	# == buscador, recibe el argumento ingresado en la vista y realiza la busqueda 
    def self.search(search)
		where('fecha like ?', "%#{search}%")
	end

	# == Este método asigna un estado a cada fcomite y lo cambia cuando esta pasado de fecha 
	def self.estado_fcomite(fecha,id)
		fecha_sp = fecha.to_time
		fecha_sp = fecha_sp + 1.days
		fecha_sp = fecha_sp.strftime("%Y-%m-%d")
		fecha_ac = Time.now
		fecha_ac = fecha_ac.strftime("%Y-%m-%d")

		if fecha_ac == fecha_sp 
			@fcomite = Fcomite.find(id)
	        @estado = Estado.find_by_nombre("realizado")
	        @fcomite.estado_id = @estado.id
	        @fcomite.save
	        return @fcomite.estado.nombre
	    else
			@fcomite = Fcomite.find(id)
	        @estado = Estado.find(@fcomite.estado_id)
	    	return @estado.nombre
		end
	end
end
