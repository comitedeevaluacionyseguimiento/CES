class Queja < ActiveRecord::Base
  
  #referencia de la tablas tipo documentos,faltas,cargos,fichas,programas y centros
  belongs_to :tipo_documento
  belongs_to :programa
  belongs_to :centro
  belongs_to :coordinador
  belongs_to :estado

  
  #atributos
 
  attr_accessible :fechainforme, :nombres, :evidencia, :apellidos, :tipo_documento_id, :identificacion, :telefono, :estado_id
  attr_accessible :email, :programa_id, :ficha, :descripcion, :falta, :testigos, :nombresinformante, :direccioninformante, :cargo, :coordinador_id
  attr_accessible :nombreinfor
         
   
  
  
  #paperclip
  has_attached_file :evidencia, :styles => { :small => "150x150>", :lsmall => "30x30>" },
  :default_url => "senac.jpg"

  
  
  #validaciones
  validates :nombres, presence: true
  validates :apellidos, presence: true
  validates :email, presence: true
  validates :ficha, presence: true


  
  #validates_attachment_presence :evidencia 
  validates_attachment_size :evidencia, :less_than => 5.megabytes
  validates_attachment_content_type :evidencia , :content_type => ['image/jpeg', 'image/png', 'imagen/jpg', 'application/pdf', 'text/plain']


  # == buscador, recibe el argumento ingresado en la vista y realiza la busqueda 
  def self.search(search)
		where('nombres like ? or apellidos like ? ', "%#{search}%", "%#{search}%")
	end

  # Este método consuta las quejas por usuario_id
  def self.indes(userid)
    @quejauser = Queja.where(:userid => userid)
  end
  
  # == Método para retornar el nombre de rol que tiene el usuario registrado
  def self.has_role(userid)
    @userid = UserRole.find_by_user_id(userid)
    @userolname = Role.find(@userid.role_id)
    @rolename = @userolname.name
    return @rolename.downcase  
  end
end
