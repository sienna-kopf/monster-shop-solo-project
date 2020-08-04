class Discount < ApplicationRecord
  validates_presence_of :percentage_discount
  validates_presence_of :item_quantity

  belongs_to :merchant

  def self.best_discount
    maximum(:percentage_discount)
  end
end
