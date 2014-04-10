class Asignacioncomite < ActiveRecord::Base
	belongs_to :programa
    belongs_to :estado
    has_many :comites

    attr_accessible :apellidos, :ficha, :nombres, :programa_id, :fecha, :estado_id, :observaciones,:quejaid


	def self.splfecd(fecha)
	    fecrea = fecha.to_s 
	  	splife = fecrea.split("-")
	  	@fcreacio = splife[0]
	end
	
	# == buscador, recibe el argumento ingresado en la vista y realiza la busqueda 
	def self.search(search)
		where('nombres like ? or apellidos like ? or fecha like ?', "%#{search}%", "%#{search}%","%#{search}%")
	end

	def self.aprendiz_queja(quejasid)

    	quejasid = quejasid.split(", ")
    	@quejas = []

    	quejasid.each do |id|
    		queja = Queja.find(id)
    		@quejas << queja
    	end
    	return @quejas
	end

end
