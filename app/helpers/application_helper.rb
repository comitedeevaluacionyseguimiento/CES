module ApplicationHelper

	# === Método para el ordenamiento por columnas
	def sortable(column, title = nil)
	  title ||= column.titleize
	  css_class = column == sort_column ? "current #{sort_direction}" : nil
	  direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	  link_to title, {:sort => column, :direction => direction}, {:class => css_class}
    end    
    # == Método que retorna el nombre del rol, para el user logueado y se ejecuta en la vista
    def has_role
		@userid = UserRole.find_by_user_id(current_user.id)
	    @userolname = Role.find(@userid.role_id)
	    @rolename = @userolname.name
	    return @rolename.downcase 
    end

    # == Este método recibe el id de comite para realizar un split a el campo idsqueja y lo retorna como un arreglo 
    def qpdf(comite)
	    @comite = Comite.find(comite)
	    @idquejas = @comite.idsqueja.split(", ")
		
		return  @idquejas
	end

end
