class Instructor < ActiveRecord::Base
	
	#atributos
    attr_accessible :apellidos, :cedula, :email, :nombres, :telefono
    
     # == buscador, recibe el argumento ingresado en la vista y realiza la busqueda 
  	def self.search(search)
		where('nombres like ?', "%#{search}%",)
	end
end
