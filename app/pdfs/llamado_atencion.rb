# encoding: UTF-8
class LlamadoAtencion < Prawn::Document

	# == Método constructor de la clase
	def initialize(historia,fecha,fecha_comite,año,view)
	   super(:margin => [20])
	   stroke_bounds
	   @historia = historia
	   @fecha = fecha
	   @fecha_comite = fecha_comite 
	   @año = año
	   logo
	   draw_text "Señor(a)", :at => [10, 620], size: 10
	   draw_text "#{@historia.queja.nombres} #{@historia.queja.apellidos} ", :at => [10, 605], size: 10
	   draw_text "Programa: #{@historia.comite.programa.descripcion} ", :at => [10, 590], size: 10
	   draw_text "Ficha: #{@historia.queja.ficha} ", :at => [10, 575], size: 10
	   draw_text "Centro de Formacion en Disaño, Confeccion y Moda  ", :at => [10, 560], size: 10
	   draw_text "Asunto: Llamado de Atención..",:at => [270, 535], size: 10
	   llamado_details
	   llamado_firmas
	   llamado_footer
	   
	end

	# == Método para definir el logo con su ubicación así como el título del pdf
	def logo
	    logopath =  "#{Rails.root}/app/assets/images/senac.jpg"
	    image logopath, :width => 60, :height => 64, :at => [250, 740]
	    draw_text "59202-1", :at => [270,660], size: 10
	    draw_text "Itagui #{@fecha}", :at => [270, 650], size: 10

	end

	# == Método para imprimir los detalles del llamado de atencion
	def llamado_details
    
	    draw_text "Respetado(a):", :at => [10, 515], size: 10
	    draw_text "Le informamos que luego de haber realizado el procedimiento para el análisis de su situación en el proceso de", :at => [10, 495], size: 10
	    draw_text "formación en términos disciplinarios, que usted adelanta; el Comité de Evaluación y Seguimiento reunido el #{@fecha_comite}", :at => [10, 484], size: 10
	    draw_text "recomienda como medida sancionatoria un llamada de atención por escrito", :at => [10, 475], size: 10

	    draw_text "Teniendo en cuenta que es un deber del Aprendiz según el artículo 1. 'Debe cumplir con todas las actividades propias  del ", :at => [10, 453], size: 10
	    draw_text "proceso de aprendizaje o del plan de mejoramiento durante su etapa lectiva y productiva'. En consecuencia se realiza:", :at => [10, 442], size: 10

	    text_box  "#{@historia.llamada_atencion}", :at => [10, 415], size: 10
	    draw_text "Según el artículo 31 del Reglamento del Aprendiz SENA, usted tiene derecho a interponer recurso de reposición, el cual", :at => [10, 386], size: 10
	    draw_text "puede llevar a cabo dentro de los 5 días hábiles luego de ser notificado. Lo invitamos a asumir una actitud más comprometida", :at => [10, 374], size: 10
	    draw_text "con su proceso de formación acorde con el Manual de Evaluación y Reglamento del Aprendiz", :at => [10, 362], size: 10
	    draw_text "Cordialmente", :at => [10, 330], size: 10
    end

    #== Método con la estructura para las firmas
    def llamado_firmas

    	draw_text "#{@historia.acta.subdirector}", :at => [270, 300], size: 10
    	draw_text "Subdirector(a)", :at => [270, 289], size: 10
    	draw_text "Centro de Formacion en Diseño, Confecion y Moda ", :at => [270, 278], size: 10
    	draw_text "La Decision, Se Notifica él ______________________ de  #{@año}, personalmente a _________________________________", :at => [10, 260], size: 10
    	draw_text "con #{@historia.aprendiz.tipo_documento.sigla} N°:#{@historia.aprendiz.num_document},  alumno(a) de: #{@historia.queja.programa.descripcion}  ", :at => [10, 240], size: 10
    	draw_text "_________________________________", :at => [10, 160], size: 10
    	draw_text "El notificador", :at => [70, 150], size: 10
    	draw_text "_________________________________", :at => [10, 130], size: 10
    	draw_text "C.C", :at => [70, 120], size: 10
    	draw_text "_________________________________", :at => [350, 160], size: 10
    	draw_text "El notificado", :at => [410, 150], size: 10
    	draw_text "_________________________________", :at => [350, 130], size: 10
    	draw_text "C.C", :at => [410, 120], size: 10
	end

	#== Método con la estructura del pie de pagina 
	def llamado_footer

		
		draw_text "Ministerio de trabajo", :at => [225, 70], size: 10
		draw_text "Servicio Nacional De Aprendizaje", :at => [190, 56], size: 11, :style => :bold
		draw_text "Regional Antioquia", :at => [220, 44], size: 11, :style => :bold
		draw_text "________________________________________________", :at => [70, 40], size: 15, :style => :bold
		draw_text "Calle  63  58B03  Itagui-Calatrava", :at => [200, 25], size: 10
		draw_text "www.sena.edu.co - Línea gratuita nacional: 01 8000 9 10 270", :at => [140, 14], size: 10
	end
end