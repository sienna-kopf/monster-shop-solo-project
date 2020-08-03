class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] += 1
  end

  def total_items
    @contents.values.sum
  end

  def items
    item_quantity = {}
    @contents.each do |item_id,quantity|
      item_quantity[Item.find(item_id)] = quantity
    end
    item_quantity
  end

  def subtotal(item)
    item.price * @contents[item.id.to_s]
  end

  def total
    @contents.sum do |item_id,quantity|
      Item.find(item_id).price * quantity
    end
  end

  def discount_total
    items.sum do |item, quantity|
      discount = Discount.find_by(merchant_id: item.merchant_id)
      if item.merchant_id == discount.merchant_id && quantity == discount.item_quantity
        (item.price - (item.price / discount.percentage_discount)) * quantity
      else
        item.price * quantity
      end
    end
  end
end
