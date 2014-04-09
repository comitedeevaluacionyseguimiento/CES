class Centro < ActiveRecord::Base
    #referencia de la tabla programas
	has_many :coordinadores
    #atributos
    attr_accessible :abreviatura, :nombre
    # == buscador, recibe el argumento ingresado en la vista y realiza la busqueda 
    def self.search(search)
		where('nombre like ?', "%#{search}%",)
	end
end
