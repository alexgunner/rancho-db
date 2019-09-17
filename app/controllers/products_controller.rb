class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_url, notice: 'Correctamente creado' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_url, notice: 'Correctamente editado' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Correctamente eliminado' }
      format.json { head :no_content }
    end
  end

  def branches
    @product_id = params[:id]
    @branch_products = BranchProduct.where(product_id: @product_id)
  end

  def add_branch
    @product_id = params[:id]
  end

  def add_product_branch
    product_id = params[:id]
    branch_product = BranchProduct.new
    branch_product.sale_cost = params[:cost]
    branch_product.product_id = product_id
    branch_product.branch_id = params[:branch][:branch_id]
    branch_product.save
    redirect_to '/products/' + product_id + '/branches'
  end

  def update_branch_cost
    product_branch_id = params[:id]
    @product_branch = BranchProduct.find(product_branch_id)
  end

  def update_branch_cost_form
    product_branch_id = params[:id]
    @product_branch = BranchProduct.find(product_branch_id)
    cost = params[:cost]
    @product_branch.sale_cost = cost
    @product_branch.save
    redirect_to '/products/' + @product_branch.product.id.to_s + '/branches'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :category_id, :picture, fitting_ids:[])
    end
end
