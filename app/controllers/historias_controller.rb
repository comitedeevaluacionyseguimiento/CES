class HistoriasController < ApplicationController

  before_filter :find_aprendiz_historia

  def index
    @historias = @aprendiz.historias.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @historias }
    end
  end

  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @historia }
    end
  end

  def new
    @historia = Historia.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @historia }
    end
  end

  def edit
  end

  def create
    @historia = @aprendiz.historia.build(params[:historia])

    respond_to do |format|
      if @historia.save
        format.html { redirect_to @historia, notice: 'Historia Creada.' }
        format.json { render json: @historia, status: :created, location: @historia }
      else
        format.html { render action: "new" }
        format.json { render json: @historia.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @historia.update_attributes(params[:historia])
        format.html { redirect_to @historia, notice: 'Historia was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @historia.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @historia.destroy

    respond_to do |format|
      format.html { redirect_to historias_url }
      format.json { head :no_content }
    end
  end

  private
  def find_aprendiz_historia
    @aprendiz = Aprendiz.find(params[:aprendiz_id])
    @historia = Historia.find(params[:id]) if params[:id]
  end
end
