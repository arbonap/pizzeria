class PizzaType < ActiveRecord::Base
  belongs_to :item
  validates :price, :name, presence: true
  validates :price, numericality: { :greater_than => 0 }
end
