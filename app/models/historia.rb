class Historia < ActiveRecord::Base
  belongs_to :aprendiz
  belongs_to :queja
  belongs_to :comite
  belongs_to :acta
  attr_accessible :llamada_atencion, :tipo_recomendacion, :aprendiz_id, :queja_id, :comite_id
end
