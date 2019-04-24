class OrderSerializer < ActiveModel::Serializer
  has_many :items
  attributes :id, :total_order_price

end
