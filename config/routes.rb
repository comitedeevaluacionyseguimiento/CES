SCQ::Application.routes.draw do

 


  resources :aprendices do
    resources :historias
  end
  
  resources :committees_members


  resources :configuraciones


  #get 'quejas/asigna', to: 'quejas#asigna'

  match "/asignar_llamado_atencion" => "actas#asignar_llamado_atencion"

  match "/llamado_atencion" => "actas#llamado_atencion"

  match "/recomendaciones" => "actas#recomendaciones"

  match "/userc" => "comites#userc"

  match "/asignar_userc" => "comites#asignar_userc"

  match "/envio_email" => "comites#envio_email"

  match "/observaciones" => "asignacioncomites#observaciones"

  match "/observacion" => "asignacioncomites#observacion"

  match "/asigna" => "quejas#asigna"

  match "/corregir" => "quejas#corregir"

  match "/cuerpo_correo_correccion" => "quejas#cuerpo_correo_correccion"

  match "/update_programa" => "asignacioncomites#update_programa"

  match "/asignar" => "asignacioncomites#asignar"

  match "/cracta" => "comites#cracta"

  match  "/crear_acta" => "comites#crear_acta"

  match  "/pdf_condicionamiento" => "actas#pdf_condicionamiento"

  match "/pdf_cancelacion" => "actas#pdf_cancelacion"

  match "/pdf_llamado_atencion" => "actas#pdf_llamado_atencion"



  match "/update_aprendices" => "asignacioncomites#update_aprendices"

  get "asignacioncomites/asignar_hora", to: "asignacioncomites#asignar_hora"
  get "comites/emails_comite", to: "comites#emails_comite"
  #match "/fcomites" => "fcomites#update_aprendices"
  
  resources :roles

  resources :estados

  resources :asignacioncomites


  resources :coordinadores


  #get 'quejas/update_ficha', to: 'quejas#update_ficha'
   
  get "logout" => "sessions#destroy", :as => "logout"

  get "login" => "sessions#new", :as => "login"
  
  get "signup" => "users#new", :as => "signup"

  get "admin" => "inicio#admin", :as => "admin"

  get "inicio/index"

  resources :users 

  resources :sessions
  resources :usercomites

 
  
  resources :fcomites do
    resources :comites do
      resources :usercomites
    end
  end
  resources :quejas

  resources :quejas do
    #ruta para el metodo de descarga de las evidencias
    member do
      get :download
    end
  end
    resources :programas
  

  resources :centros do
     resources :coordinadores do
      resources :programas
    end
  end

  resources :instructores


  resources :actas

  resources :cargos
    resources :tipos_documentos
  
  
  resources :ayudas do
    member do
      get :download
    end
  end
  
  #ruta select de fichas
  #match "/update_fichas" => "quejas#update_fichas"

  #ruta select de programas
  #match "/update_programas" => "quejas#update_programas"

  root :to => 'inicio#index'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
