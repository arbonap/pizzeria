class OrdersController < ApplicationController
  # Need to turn off CSRF token authentication in order to do curl requests
  skip_before_action :verify_authenticity_token
  before_action :set_order, only: [:show, :update, :destroy]

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

  # POST /orders
  def create
    begin
      @order = Order.create
      params[:order][:items].map do |item|
        Item.create(:quantity => item[:quantity],
                    :order => @order,
                    :pizza_type => PizzaType.create(:name => item[:pizza_type][:name],
                    :price => item[:pizza_type][:price]))
      end

      @order.save
      render json: @order
    rescue NoMethodError, TypeError, ActiveRecord::RecordInvalid
      render json: { errors: @order.errors }, status: 422
    end
  end

  # PATCH/PUT /orders/1
  def update
    begin
      Item.where(order_id: @order.id).destroy_all

      params[:params][:order][:items].map do |item|
        Item.create(:quantity => item[:quantity],
                    :order => @order,
                    :pizza_type => PizzaType.create(:name => item[:pizza_type][:name],
                    :price => item[:pizza_type][:price]))
      end
      @order.save
      render json: @order
    rescue NoMethodError, TypeError, ActiveRecord::RecordInvalid
      render json: { errors: @order.errors }, status: 422
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
      format.json { head :no_content }
  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

    def order_params
      params.require(:order).permit(items: [:quantity, {pizza_type: [:name, :price]}])
    end
end
