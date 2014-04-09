class ConfiguracionesController < ApplicationController

  def index
    @configuraciones = Configuracion.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @configuraciones }
    end
  end

  def show
    @configuracion = Configuracion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @configuracion }
    end
  end

  def new
    @configuracion = Configuracion.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @configuracion }
    end
  end

  def edit
    @configuracion = Configuracion.find(params[:id])
  end

  def create
    @configuracion = Configuracion.new(params[:configuracion])

    respond_to do |format|
      if @configuracion.save
        format.html { redirect_to @configuracion, notice: 'Configuracion was successfully created.' }
        format.json { render json: @configuracion, status: :created, location: @configuracion }
      else
        format.html { render action: "new" }
        format.json { render json: @configuracion.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @configuracion = Configuracion.find(params[:id])

    respond_to do |format|
      if @configuracion.update_attributes(params[:configuracion])
        format.html { redirect_to @configuracion, notice: 'Configuracion was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @configuracion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @configuracion = Configuracion.find(params[:id])
    @configuracion.destroy

    respond_to do |format|
      format.html { redirect_to configuraciones_url }
      format.json { head :no_content }
    end
  end
end
