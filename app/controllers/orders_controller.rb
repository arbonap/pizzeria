class OrdersController < ApplicationController
  # Need to turn off CSRF token authentication in order to do curl requests
  skip_before_action :verify_authenticity_token
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  def index
    @orders = Order.all

    render json: @orders
  end

  # GET /orders/1
  def show
    @order = set_order

    render json: @order
  end

  # GET /orders/new
  def new
    @order = Order.new()
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.create
    params[:order][:items].map do |item|
      Item.create(:quantity => item[:quantity],
                  :order => @order,
                  :pizza_type => PizzaType.create(:name => item[:pizza_type][:name],
                  :price => item[:pizza_type][:price]))
    end

    respond_to do |format|
      if @order.save
        format.json { render :show, status: :created, location: @order }
      else
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.json { render :show, status: :ok, location: @order }
      else
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

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(items: [:quantity, {pizza_type: [:name, :price]}])
    end
end
