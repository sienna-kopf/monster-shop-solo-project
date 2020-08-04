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

  def discount_subtotal(item)
    discount_price(item) * @contents[item.id.to_s]
  end

  def total
    @contents.sum do |item_id,quantity|
      Item.find(item_id).price * quantity
    end
  end

  def discount_total
    if discount_applies
      @contents.sum do |item_id, quantity|
        if has_discount(Item.find_by(id: item_id))
          discount_price(Item.find(item_id)) * quantity
        else
          Item.find(item_id).price * quantity
        end
      end
    end
  end

  def has_discount(item)
    !Discount.find_by(merchant_id: item.merchant_id).nil? && Discount.find_by(merchant_id: item.merchant_id).item_quantity <= items[item]
  end

  def discounts(item)
    Discount.where(merchant_id: item.merchant_id)
  end

  def discount_applies
    @contents.any? do |item_id, quantity|
      has_discount(Item.find_by(id: item_id))
    end
  end

  def best_discount(item)
    if discounts(item).all? {|discount| discount.item_quantity <=  items[item]}
      Discount.find_by(percentage_discount: discounts(item).best_discount)
    else
      discounts(item).where('item_quantity <= ?', items[item]).first
    end
  end

  def discount_price(item)
    return item.price if !has_discount(item)
    item.price * (1 - best_discount(item).percentage_discount.to_f / 100 )
  end
end
