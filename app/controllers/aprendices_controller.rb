class AprendicesController < ApplicationController

  def index
   
    if params[:search]
      @searc = params[:search]
    else
      @searc = ""
    end

    @aprendices = Aprendiz.search(params[:search]).page(params[:page]).per_page(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @aprendices }
    end
  end

  def show
    @aprendiz = Aprendiz.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @aprendiz }
    end
  end

  def new
    @aprendiz = Aprendiz.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @aprendiz }
    end
  end

  def edit
    @aprendiz = Aprendiz.find(params[:id])
  end

  def create
    @aprendiz = Aprendiz.new(params[:aprendiz])

    respond_to do |format|
      if @aprendiz.save
        format.html { redirect_to @aprendiz, notice: 'Aprendiz was successfully created.' }
        format.json { render json: @aprendiz, status: :created, location: @aprendiz }
      else
        format.html { render action: "new" }
        format.json { render json: @aprendiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @aprendiz = Aprendiz.find(params[:id])

    respond_to do |format|
      if @aprendiz.update_attributes(params[:aprendiz])
        format.html { redirect_to @aprendiz, notice: 'Aprendiz was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @aprendiz.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @aprendiz = Aprendiz.find(params[:id])
    @aprendiz.destroy

    respond_to do |format|
      format.html { redirect_to aprendices_url }
      format.json { head :no_content }
    end
  end
end
