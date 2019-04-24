class PizzaTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :price
  belongs_to :item
end
