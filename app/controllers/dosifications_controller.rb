class DosificationsController < ApplicationController
  before_action :set_dosification, only: [:show, :edit, :update, :destroy]

  # GET /dosifications
  # GET /dosifications.json
  def index
    @dosifications = Dosification.all
  end

  # GET /dosifications/1
  # GET /dosifications/1.json
  def show
  end

  # GET /dosifications/new
  def new
    @dosification = Dosification.new
  end

  # GET /dosifications/1/edit
  def edit
  end

  # POST /dosifications
  # POST /dosifications.json
  def create
    @dosification = Dosification.new(dosification_params)

    respond_to do |format|
      if @dosification.save
        format.html { redirect_to dosifications_url, notice: 'Dosificación creada correctamente' }
        format.json { render :show, status: :created, location: @dosification }
      else
        format.html { render :new }
        format.json { render json: @dosification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dosifications/1
  # PATCH/PUT /dosifications/1.json
  def update
    respond_to do |format|
      if @dosification.update(dosification_params)
        format.html { redirect_to dosifications_url, notice: 'Dosificación editada correctamente' }
        format.json { render :show, status: :ok, location: @dosification }
      else
        format.html { render :edit }
        format.json { render json: @dosification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dosifications/1
  # DELETE /dosifications/1.json
  def destroy
    @dosification.destroy
    respond_to do |format|
      format.html { redirect_to dosifications_url, notice: 'Dosificación eliminada correctamente' }
      format.json { head :no_content }
    end
  end

  def code_control_test
    
  end

  def test_code_control
    authorization_number = params[:auth_number]
    invoice_number = params[:in_number].to_i
    invoice_nit = params[:nit_number].to_i
    date = params[:in_date]
    date = date.split("-")
    invoice_date = date[0] + date[1] + date[2]
    invoice_amount = params[:in_amount].to_f
    invoice_key = params[:in_key]
    a = Order.new

    @final_code = a.show_code_control authorization_number, invoice_number, invoice_nit, invoice_date, invoice_amount, invoice_key
    @final_code
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dosification
      @dosification = Dosification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dosification_params
      params.require(:dosification).permit(:authorization_number, :dosification_key, :valid_until, :activity, :branch_id)
    end
end
