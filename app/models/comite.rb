# encoding: UTF-8
class Comite < ActiveRecord::Base
  
  #referencia de las tablas padre e hijas
  has_many :actas
  belongs_to :queja
  belongs_to :falta
  belongs_to :prioridad
  belongs_to :fcomite
  has_many   :usercomites
  belongs_to :programa
  belongs_to :asignacioncomite

  #atributos
  attr_accessible :idsqueja, :hora, :nombreapren,:programa_id, :ficha, :fcomite_id, :asignacioncomite_id, :quejaid 
  # == buscador, recibe el argumento ingresado en la vista y realiza la busqueda 
  def self.search(search)
		where('hora like ?', "%#{search}%",)
	end

  # == Método para recobrar los correos de los usuarios del comite 
  def self.emails(emails)
    @fcreacio = emails.split(",")
    return  @fcreacio
  end

  # == Este método recibe la fecha del comite y organiza el formato de esta manera => "2014/Marzo/05", y retorna el año actual
  def self.fechaes
    fecha = Time.now
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
    @fecha = fecha.strftime("%d/#{@m}/%Y")
    @año = fecha.strftime("%Y")
    return @fecha, @año
  end

  # == Este método recibe el id de acta busca  el comite al que pertenece esa acta, recupera los id de queja en el comite
  # == se realiza un ciclo por queja,se trae la historia por queja y se guarda el acta dento de la historia
  def self.acta_historia(acta)

    @acta     = acta
    @comite   = Comite.find(@acta.comite_id)
    @idsq     = @comite.idsqueja
    @idsqueja = @idsq.split(", ")

    @idsqueja.each do |queja|
      @historia         = Historia.find_by_queja_id(queja)
      @historia.acta_id = @acta.id
      @historia_update  = @historia.save
    end
    return @historia_update 
  end
end
