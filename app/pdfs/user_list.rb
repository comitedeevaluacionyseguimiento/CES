# encoding: UTF-8
class UserList < Prawn::Document

  # == Método constructor de la clase userlist 

  def initialize(users, view)
     super()
     logo 
     @users = users
     @vista = view
     user_details
  end

  #Método para definir el logo con su ubicación así como el título del reporte  
  def logo
    logopath =  "#{Rails.root}/app/assets/images/senac.jpg"
    image logopath, :width => 80, :height => 90
    move_down 10
    draw_text "Listado de usuarios", :at => [150, 575], size: 22
    text "Logo"
  end

  #Método para dar formato a la salida de los registros
  def precision(num)
    @vista.number_with_precision(num, :locale => :es ,:precision => 2, :separator => ",", :delimiter => '.')
  end

  #Método para almacenar y mostrar los registros del detalle de la orden
  def user_item_rows
    [["Nombre", "Username", "Email"]] +
    @users.map do |user|
      [ "#{user.nombre} ",
        "#{user.username} ",
        "#{user.email} ",
      ]
    end
  end

  #Método que imprime la tabla de las ordenes que hay
  def user_details
    move_down 80
    table user_item_rows, :width => 300 do
      row(0).font_style = :bold
      columns(1..3).align = :right
      self.header = true
      self.column_widths = {0 => 100, 1 => 100, 2 => 100}
    end
  end
end
