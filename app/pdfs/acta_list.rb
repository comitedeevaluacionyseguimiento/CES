# encoding: UTF-8
class ActaList < Prawn::Document

  # == Método constructor de la clase actalist 

  def initialize(nombres,ficha,plural_singular,actas,view)
     super()
     @actas = actas
     @vista = view 
     @nombres = nombres
     @ficha = ficha
     @plural_singular =  plural_singular
     header
     body
  end

  # == Método para definir el logo con su ubicación así como el título del reporte  
  def header

    logopath =  "#{Rails.root}/app/assets/images/senac.jpg"
    image logopath, :width => 50, :height => 64, :at => [10,718]

    my_table = make_table([ ["                                             "], ["                                         "], ["                     "] ])
    table([["                    ", "                                                                                                         ", my_table]])

    
    move_down 10
    draw_text "SISTEMA INTEGRADO DE GESTIÓN", :at => [100, 705], size: 14
    draw_text "ACTA", :at => [200, 686], size: 14
    draw_text "Proceso Direccionamiento Estratégico", :at => [110, 670],size: 13
    draw_text "Procedimiento Control de Documentos y Registros", :at => [85, 656], size: 13
    draw_text "Código:  F002-P001-DE", :at => [395, 705], size: 13
    draw_text "Versión: 02", :at => [395, 680], size: 13
    draw_text "#{@actas.fecha}", :at => [395,656], size: 13
  end
  # == Método para imprimir el cuerpo del pdf
  def body

    bounding_box [0, cursor], :width => bounds.right, :height => 40 do
      
      text "Reunion Acta #{@actas.num_acta}", :align => :center, :valign => :center
      transparent(2) { stroke_bounds }
    end

    table([
      ["Itagui, Fecha \n\n  #{@actas.fecha}               ", "Hora inicio \n\n  #{@actas.hora_inicio}               ","Hora Terminacion \n\n   #{@actas.hora_terminacion}               "]
    ])

    bounding_box [0, cursor], :width => bounds.right, :height => 60 do
    
      text "  LUGAR: \n#{@actas.comite.fcomite.lugar} ", :valign => :center
      transparent(2) { stroke_bounds }
    end

    bounding_box [0, cursor], :width => bounds.right, :height => 40 do
    
      text "  Tema:  "+"Comite #{@actas.comite.fcomite.tipo} de Evaluación y  Seguimiento ", :valign => :center
      transparent(2) { stroke_bounds }
    end

    table([
        ["OBJETIVO DE LA REUNIÓN:\n Analizar las dificultades en téminos disciplinarios y académicas  frente a su proceso de formación #{@plural_singular} de #{@actas.comite.programa.descripcion}, Ficha #{@ficha} \n 
          #{@nombres}" ]
      ])
    bounding_box [0, cursor], :width => bounds.right, :height => 40 do
    
      text "Desarrollo  Reunion:",:align => :center, :valign => :center
      transparent(2) { stroke_bounds }
    end

    table([["El Comité #{@actas.comite.fcomite.tipo} de Evaluacion y Seguimiento, se reunió con el propósito de analizar la situación #{@plural_singular} #{@nombres}, en términos Diciplinarios y Académicos, frente a su proceso de formación. Los aprendices fueron citados dando cumplimiento al debido proceso, permitiédoles realizar los descargos pertinentes, sobre la queja presentada por la instructora: \n\n #{@actas.desarrollo_reunion},"],
        ["Conclusiones:  \n\n El Comité #{@actas.comite.fcomite.tipo} de Evaluación y Seguimiento recomienda para los aprendices: \n\n #{@actas.conclusiones}"]
    ])

    draw_text "________________________", :at => [0,100], size: 12
    draw_text "Recibido Registro y Certificacón ", :at => [0,80], size: 11
    draw_text "________________________", :at => [350,100], size: 12
    draw_text "Oficina de Bienestar ", :at => [350,80], size: 11

  end
end
