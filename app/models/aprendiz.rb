class Aprendiz < ActiveRecord::Base
    belongs_to :tipo_documento
	belongs_to :programa
	has_many :historias
	attr_accessible :ficha, :name, :num_document, :tipo_documento_id, :programa_id

    # == buscador, recibe el argumento ingresado en la vista y realiza la busqueda 
    def self.search(search)
		where('name like ? or num_document like ?', "%#{search}%", "%#{search}%")
	end
end
