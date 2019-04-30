require 'rails_helper'
RSpec.describe OrdersController, type: :controller do
  let(:valid_attributes) { {:items => [Item.create(:quantity => 2, :pizza_type => PizzaType.create(:name => 'Pepperoni', :price => 9.00))]}
  }

  let(:valid_session) { {:items => [Item.create(:quantity => 2, :pizza_type => PizzaType.create(:name => 'Pepperoni', :price => 9.00))]}
  }

  describe "GET #index" do
    it "returns a success response" do
      Order.create! valid_attributes
      get :index, {}, valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      order = Order.create! valid_attributes
      get :show, {:id => order.to_param}, valid_session
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
      it "should not create an order, and raise TypeError" do
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
        # TODO: check other attributes here
        expect(@order.items[0].pizza_type.name).to eq("Supreme")
      end
    end

    # context "with invalid params" do
    #   it "returns a success response (i.e. to display the 'edit' template)" do
    #     order = Order.create! valid_attributes
    #     put :update, {:id => order.to_param, :order => invalid_attributes}, valid_session
    #     expect(response).to be_successful
    #   end
    # end
  end
end
