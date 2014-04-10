class Historia < ActiveRecord::Base
  belongs_to :aprendiz
  belongs_to :queja
  belongs_to :comite
  belongs_to :acta
  attr_accessible :fecha, :llamada_atencion, :tipo_recomendacion, :aprendiz_id, :queja_id, :comite_id

  # == buscador, recibe el argumento ingresado en la vista y realiza la busqueda 
    def self.search(search)
		where('fecha like ? ', "%#{search}%")
    end
end
