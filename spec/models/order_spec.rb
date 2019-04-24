require 'rails_helper'

RSpec.describe Order, type: :model do

  it { should have_many(:items) }
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it "should calculate the total_order_price" do
    @pepperoni = PizzaType.create(:name => 'Pepperoni', :price => 9.00)
    @vegetarian = PizzaType.create(:name => 'Vegetarian', :price => 8.00)
    @item_one = Item.create(:quantity => 2, :pizza_type => @pepperoni)
    @item_two = Item.create(:quantity => 3, :pizza_type => @vegetarian)
    @order = Order.create(:items => [@item_one, @item_two])
    @total_order_price = @order.total_order_price
    
    expect(@total_order_price).to eq("42.00")
  end
end
