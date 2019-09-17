class FittingsController < ApplicationController
  before_action :set_fitting, only: [:show, :edit, :update, :destroy]

  # GET /fittings
  # GET /fittings.json
  def index
    @fittings = Fitting.all
  end

  # GET /fittings/1
  # GET /fittings/1.json
  def show
  end

  # GET /fittings/new
  def new
    @fitting = Fitting.new
  end

  # GET /fittings/1/edit
  def edit
  end

  # POST /fittings
  # POST /fittings.json
  def create
    @fitting = Fitting.new(fitting_params)

    respond_to do |format|
      if @fitting.save
        format.html { redirect_to fittings_url, notice: 'Correctamente creado' }
        format.json { render :show, status: :created, location: @fitting }
      else
        format.html { render :new }
        format.json { render json: @fitting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fittings/1
  # PATCH/PUT /fittings/1.json
  def update
    respond_to do |format|
      if @fitting.update(fitting_params)
        format.html { redirect_to fittings_url, notice: 'Correctamente editado' }
        format.json { render :show, status: :ok, location: @fitting }
      else
        format.html { render :edit }
        format.json { render json: @fitting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fittings/1
  # DELETE /fittings/1.json
  def destroy
    @fitting.destroy
    respond_to do |format|
      format.html { redirect_to fittings_url, notice: 'Correctamente eliminado' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fitting
      @fitting = Fitting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fitting_params
      params.require(:fitting).permit(:name, :description, :cost)
    end
end
