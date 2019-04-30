class Item < ActiveRecord::Base
  has_one :pizza_type, dependent: :destroy
  belongs_to :order

  validates :quantity, :pizza_type, presence: true
  validates :quantity, numericality: { :greater_than => 0 }

  serialize :total_item_price, :item_price

  def item_price
    monetize(total_item_price)
  end

  def total_item_price
    quantity * pizza_type.price
  end

  private
  def monetize(money_big_num)
    '%.2f' % money_big_num
  end
end
