require 'rails_helper'

describe Discount, type: :model do
  describe 'validations' do
    it {should validate_presence_of :percentage_discount}
    it {should validate_presence_of :item_quantity}
  end
  describe 'relationships' do
    it {should belong_to :merchant}
  end
end
