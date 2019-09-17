class CombosController < ApplicationController
  before_action :set_combo, only: [:show, :edit, :update, :destroy]

  # GET /combos
  # GET /combos.json
  def index
    @combos = Combo.all
  end

  # GET /combos/1
  # GET /combos/1.json
  def show
  end

  # GET /combos/new
  def new
    @combo = Combo.new
  end

  # GET /combos/1/edit
  def edit
  end

  # POST /combos
  # POST /combos.json
  def create
    @combo = Combo.new(combo_params)

    respond_to do |format|
      if @combo.save
        format.html { redirect_to combos_url, notice: 'Correctamente creado' }
        format.json { render :show, status: :created, location: @combo }
      else
        format.html { render :new }
        format.json { render json: @combo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /combos/1
  # PATCH/PUT /combos/1.json
  def update
    respond_to do |format|
      if @combo.update(combo_params)
        format.html { redirect_to combos_url, notice: 'Correctamente editado' }
        format.json { render :show, status: :ok, location: @combo }
      else
        format.html { render :edit }
        format.json { render json: @combo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /combos/1
  # DELETE /combos/1.json
  def destroy
    @combo.destroy
    respond_to do |format|
      format.html { redirect_to combos_url, notice: 'Correctamente eliminado' }
      format.json { head :no_content }
    end
  end

  def products
    @combo_id = params[:id]
    @combo_products = BranchComboProduct.where(combo_id: @combo_id)
  end

  def add_product
    @combo_id = params[:id]
    combo = Combo.find(@combo_id)
    branch_products = BranchProduct.where(branch_id: combo.branch_id)
    @products = []
    branch_products.each do |branch_product|
      @products.push branch_product.product
    end
  end

  def add_product_combo
    combo_id = params[:id]
    combo = Combo.find(combo_id)
    branch_product = BranchProduct.where(product_id: params[:product][:product_id]).where(branch: combo.branch_id).first
    branch_combo_product = BranchComboProduct.new
    branch_combo_product.branch_product_id = branch_product.id
    branch_combo_product.combo_id = combo_id
    branch_combo_product.save
    redirect_to '/combos/' + combo_id + '/products'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_combo
      @combo = Combo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def combo_params
      params.require(:combo).permit(:name, :description, :sale_cost, :branch_id, :picture, fitting_ids:[])
    end
end
