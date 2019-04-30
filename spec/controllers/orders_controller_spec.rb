require 'rails_helper'
RSpec.describe OrdersController, type: :controller do
  let(:valid_attributes) { {:items => [Item.create(:quantity => 2, :pizza_type => PizzaType.create(:name => 'Pepperoni', :price => 9.00))]}
  }

  describe "GET #index" do
    it "returns a success response" do
      Order.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      order = Order.create! valid_attributes
      get :show, {:id => order.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do

    let(:margherita_params) {
      {order: {items: [{quantity:"3",pizza_type:{name: "Margherita", price: "10"}}]}}
    }

    let(:meat_params) {
      {order: {items: [{quantity:"2",pizza_type:{name: "Meat Lover's", price: "12"}}]}}
    }

    let(:invalid_params) {
      {order: {items: {quantity:"2"}}}
    }

    context "with valid params" do

      it "has status of 200 OK" do
        post :create, margherita_params
        expect(response.status).to eq(200)
      end

      it "creates a new Order" do
        expect {
          post :create, meat_params
        }.to change(Order, :count).by(1)
      end
    end

    context "with invalid params" do
      it "should not create an order, and rescue TypeError exception" do
        post :create, invalid_params
        expect(response).to_not be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:margherita_params) {
        {order: {items: [{quantity:"3",pizza_type:{name: "Margherita", price: "10"}}]}}
      }

      let(:new_attributes) {
        {order: {items: [{quantity:"2",pizza_type:{name: "Supreme", price: "5"}}]}}
      }

      it "updates the requested order" do
        @order = Order.create! valid_attributes

        put :update, {:id => @order.to_param, :params => new_attributes}
        @order.reload

        expect(@order.items[0].quantity).to eq(2)
        expect(@order.items[0].pizza_type.name).to eq("Supreme")
        expect(@order.items[0].pizza_type.price.to_i).to eq(5)
      end

      it "should not create a new Order" do
        @order = Order.create! valid_attributes

        expect {
          put :update, {:id => @order.to_param, :params => new_attributes}
        }.to change(Order, :count).by(0)
      end
    end

    context "with invalid params" do
      let(:invalid_params) {
        {order: {items: {quantity:"5"}}}
      }

      it "should not update an order and rescue a TypeError Exception" do
        order = Order.create! valid_attributes
        put :update, {:id => order.to_param, :order => invalid_params}
        expect(response).to_not be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid record" do
      it "deletes an order" do
        @order = Order.create! valid_attributes
        delete :destroy, {:id => @order.to_param}
        expect(response).to be_successful
      end

      it "should decrement Order count" do
        @order = Order.create! valid_attributes

        expect {
          delete :destroy, {:id => @order.to_param}
        }.to change(Order, :count).by(-1)
      end
    end
  end
end
