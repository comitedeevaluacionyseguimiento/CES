class Programa < ActiveRecord::Base
    
    #referencia de las tablas quejas,centros y fichas 
    has_many :quejas
    belongs_to :coordinador
    
    #atributos
    attr_accessible :abreviatura, :descripcion, :coodinador_id, :estado

    # == buscador, recibe el argumento ingresado en la vista y realiza la busqueda 
    def self.search(search)
		where('descripcion like ?', "%#{search}%",)
	end

	def self.getIds(programa)
		where('id in (?)', "#{programa}")
	end

	
end
