class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  
  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all.reverse_order.take(100)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.status = false
    @order.order_state = true
    respond_to do |format|
      if @order.save
        format.html { redirect_to '/order_details/' + @order.id.to_s, notice: 'Órden creada correctamente' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Órden editada correctamente' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def products
    @order = Order.find(params[:id])
    @order_items = OrderItem.where(order_id: @order.id)
  end

  def add_product
    @order = Order.find(params[:id])
    @products = []
    BranchProduct.all.each do |branch_product|
      if branch_product.branch_id == @order.branch_id
        @products.push branch_product.product
      end
    end
  end

  def add_combo
    @order = Order.find(params[:id])
    @combos = Combo.where(branch_id: @order.branch_id)
  end

  def add_product_order
    order = Order.find(params[:id])
    order_item = OrderItem.new
    product_id = params[:product][:product_id]
    branch_product = BranchProduct.where(product_id: product_id).where(branch_id: order.branch_id).first
    order_item.branch_product_id = branch_product.id
    order_item.quantity = params[:quantity]
    order_item.order_id = order.id
    order_item.save
    redirect_to '/orders/' + order.id.to_s + '/products'
  end

  def add_combo_order
    order = Order.find(params[:id])
    combo = Combo.find(params[:combo][:combo_id])
    order_item = OrderItem.new
    order_item.combo_id = combo.id
    order_item.quantity = params[:quantity]
    order_item.order_id = order.id
    order_item.save
    redirect_to '/orders/' + order.id.to_s + '/products'
  end

  def close
    order = Order.find(params[:id])
    order.status = true
    order.save
    redirect_to '/orders/' + order.id.to_s + '/products'
  end

  def print
    @order = Order.find(params[:id])
    @items = @order.order_items
    @invoice = Invoice.find_by(order_id: @order.id)
    render layout: false
  end

  def partial_print
    @order = Order.find(params[:id])
    @items = @order.order_items
    render layout: false
  end

  def order_details
    @order = Order.find(params[:id])

    if @order.order_discounts.count != 0
      @discount_p = @order.order_discounts.last.discount
    else
      @discount_p = Discount.find_by(name: "Ninguno")
    end
    @categories = Category.all
    @products = @order.branch.products_in_branch
    @combos = Combo.where(branch_id: @order.branch_id)
    @order_items = OrderItem.where(order_id: @order.id).reverse_order
  end

  def order_now
    order = Order.find(params[:order_id])
    branch_id = order.branch_id
    order_name = params[:name]
    order_nit = params[:nit]
    order_discount = params[:discount][:discount]
    or_discount = OrderDiscount.new
    or_discount.order_id = order.id
    or_discount.discount_id = order_discount
    or_discount.save
    order.name = order_name
    order.nit = order_nit
    order.details = params[:details]
    order.amount_payed = params[:amount_payed]
    order.save
    if !params[:products].nil?  
      params[:products].each do |key, value|
        product_id = key
        quantity = value.first.to_i
        if quantity != 0
          order_item = OrderItem.new
          branch_product = BranchProduct.where(product_id: product_id).where(branch_id: order.branch_id).first  
          order_item.branch_product_id = branch_product.id
          order_item.quantity = quantity
          order_item.order_id = order.id
          order_item.save

          value.each_with_index do |fitting, index|
            if index != 0
              order_item_fitting = OrderItemFitting.new
              order_item_fitting.order_item_id = order_item.id
              order_item_fitting.fitting_id = fitting
              order_item_fitting.save
            end
          end
        end
      end
    end

    if !params[:combos].nil?
      params[:combos].each do |key, value|
        combo_id = key
        quantity = value.first.to_i
        if quantity != 0
          order_item = OrderItem.new
          order_item.combo_id = combo_id
          order_item.quantity = quantity
          order_item.order_id = order.id
          order_item.save

          value.each_with_index do |fitting, index|
            if index != 0
              order_item_fitting = OrderItemFitting.new
              order_item_fitting.order_item_id = order_item.id
              order_item_fitting.fitting_id = fitting
              order_item_fitting.save
            end
          end
        end
          
      end
    end
    redirect_to '/order_details/' + order.id.to_s
  end

  def close_shift
    @orders = Order.all
    @today_orders = []
    @orders.each do |order|
      if order.created_at < Date.tomorrow and order.created_at > Date.yesterday
        @today_orders.push(order)
      end
    end
    @number_orders = @today_orders.count
  end

  def remove_item
    order_item = OrderItem.find(params[:id])
    order_id = order_item.order_id
    order_item.delete
    redirect_to '/order_details/' + order_id.to_s
  end

  def disable_order
    order = Order.find(params[:id])
    order.order_state = false
    order.save
    redirect_back(fallback_location: '/reports')
  end

  def enable_order
    order = Order.find(params[:id])
    order.order_state = true
    order.save
    redirect_back(fallback_location: '/reports')
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :nit, :branch_id)
    end
end
