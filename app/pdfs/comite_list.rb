# encoding: UTF-8
class ComiteList < Prawn::Document

  # == Método constructor de la clase comitelist 

  def initialize(comites, fcomite, view )
   super()
   logo 
   @comites = comites
   @fcomite = fcomite
   @vista = view
   draw_text "Programación Comité #{@fcomite.tipo}", :at => [105, 620], size: 18
   draw_text "Lugar: #{@fcomite.lugar}", :at => [180, 590], size: 18
   draw_text "Fecha: #{@fcomite.fecha}", :at => [235, 563], size: 18
   comite_details
  end

  # == Método para definir el logo con su ubicación así como el título del reporte  
  def logo
    logopath =  "#{Rails.root}/app/assets/images/senac.jpg"
    image logopath, :width => 60, :height => 74

    logoscm = "#{Rails.root}/app/assets/images/scm.png"
    image logoscm, :at => [450, 750], :scale => 0.48
    move_down 10
    draw_text "CENTRO DE FORMACIÓN EN DISEÑO, CONFECCIÓN Y MODA", :at => [70, 700], size: 15
    draw_text "COMITÉ  DE EVALUCIÓN Y SEGUIMIENTO", :at => [145, 670], size: 15
  end


  # == Método para almacenar y mostrar los registros del detalle de la orden
  def comite_item_rows
    
    [[ "Hora","Nombre Aprendices", "Programa","Ficha","Miembros Comite","comentarios"]]+

    @comites.map do |comite|
      

      [
        "#{comite.hora} ",
        "#{comite.nombreapren} ",
        "#{comite.programa.abreviatura} ",
        "#{comite.ficha} ",

        @userscomites = userscomite(comite.id),
        "#{comite.asignacioncomite.observaciones}"
      ]

    end 
  end

  # == Método que recupara los nombres de los usuarios para imprimirlos en el pdf 
  def userscomite(comiteid)
      @comite = Comite.find(comiteid)
      @usuarios = @comite.usercomites.all

      @cadena = ""
      @usuarios.map do |uc|
        @cadena += "#{uc.nombre}"
      end
      return @cadena
  end 
  # == Método que imprime la tabla de las ordenes que hay
  def comite_details
    move_down 80
    table comite_item_rows, :width =>  570 do
      row(0).font_style = :bold
      self.header = true
      self.column_widths = {0 => 65, 1 => 130, 2 => 70, 3 => 65,4 => 130,5=>110}
    end
  end
end