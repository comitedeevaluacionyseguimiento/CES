module ActasHelper

	# == Este método recibe el id de acta para realizar un split a el campo idsqueja y lo retorna como un arreglo 
	def vpdf(acta)
		@acta = Acta.find(acta)
	    @comite = Comite.find(@acta.comite_id)
	    @idquejas = @comite.idsqueja.split(", ")
		
		return  @idquejas
	end

	# == Este método retorna el nombre del aprendiz que esta en la queja
	def name(queja)
		@queja = Queja.find(queja)
	    @nombre = "#{@queja.nombres}" 
		return  @nombre
	end
end
