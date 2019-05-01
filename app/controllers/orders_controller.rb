class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

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
    Item.where(order_id: @order.id).destroy_all
    begin
      params[:order][:items].map do |item|
        Item.create(:quantity => item[:quantity],
                    :order => @order,
                    :pizza_type => PizzaType.create(:name => item[:pizza_type][:name],
                    :price => item[:pizza_type][:price]))
      end
      @order.save
      render json: @order
    rescue TypeError, NoMethodError
      render json: { errors: @order.errors }, status: 422
    end
  end

  # DELETE /orders/1
  def destroy
    begin
      @order.destroy
      head :no_content
    rescue NoMethodError
      render json: { errors: @order.errors }, status: 422
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
