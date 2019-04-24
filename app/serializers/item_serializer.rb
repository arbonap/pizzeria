class ItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :pizza_type, :item_price

  has_one :pizza_type
  belongs_to :order

  def pizza_type
    object.pizza_type
  end
end
