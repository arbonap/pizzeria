require 'rails_helper'

RSpec.describe PizzaType, type: :model do
  setup do
    @pepperoni = PizzaType.create(:name => 'Pepperoni', :price => 9.00)
    @vegetarian = PizzaType.create(:name => 'Vegetarian', :price => 8.00)
    @item_one = Item.create(:quantity => 2, :pizza_type => @pepperoni)
    @item_two = Item.create(:quantity => 3, :pizza_type => @vegetarian)
    @order = Order.create(:items => [@item_one, @item_two])
    @price = @pepperoni.price.to_i
  end

    subject! { @pepperoni }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:price) }
    it { expect(@price).to be > 0 }
    it { should belong_to(:item) }
    it { should have_db_column(:name) }
    it { should have_db_column(:price) }
    it { should have_db_index(:item_id) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
end
