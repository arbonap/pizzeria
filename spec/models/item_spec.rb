require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should validate_presence_of(:quantity) }
  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  it { should belong_to(:order) }
  it { should have_one(:pizza_type) }

  it { should have_db_column(:quantity) }
  it { should have_db_column(:order_id) }
  it { should have_db_index(:order_id) }
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it "should calculate the item_price" do
    @pepperoni = PizzaType.create(:name => 'Pepperoni', :price => 9.00)
    @vegetarian = PizzaType.create(:name => 'Vegetarian', :price => 8.00)
    @item_one = Item.create(:quantity => 2, :pizza_type => @pepperoni)
    @item_two = Item.create(:quantity => 3, :pizza_type => @vegetarian)
    @total_item_price_one = @item_one.total_item_price
    @total_item_price_two = @item_two.total_item_price
    @item_price_item_one = @item_one.item_price
    @item_price_item_two = @item_two.item_price

    expect(@total_item_price_one).to eq(18.0)
    expect(@total_item_price_two).to eq(24.0)
    expect(@item_price_item_one).to eq("18.00")
    expect(@item_price_item_two).to eq("24.00")
  end

  it "should serialize item attributes" do

    @pineapple = PizzaType.create(:name => 'Pineapple', :price => 9.00)
    @item = Item.create(:quantity => 2, :pizza_type => @pineapple)
    @item_serializer = ItemSerializer.new(@item)
    @hash = @item_serializer.serializable_hash

    expect(@hash[:id]).to be_present
    expect(@hash[:quantity]).to eq(2)
    expect(@hash[:item_price]).to eq("18.00")
    expect(@hash[:pizza_type][:name]).to eq("Pineapple")
    expect(monetize(@hash[:pizza_type][:price].to_i)).to eq("9.00")
  end
end
