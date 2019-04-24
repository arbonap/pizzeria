class Order < ActiveRecord::Base
  has_many :items
  serialize :total_order_price

  def total_order_price
    monetize(item_prices.reduce(:+))
  end

  private
  def monetize(money_big_num)
    '%.2f' % money_big_num
  end

  def item_prices
    items.map(&:total_item_price)
  end
end
