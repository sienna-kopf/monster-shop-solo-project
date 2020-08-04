require 'rails_helper'

describe Discount, type: :model do
  describe 'validations' do
    it {should validate_presence_of :percentage_discount}
    it {should validate_presence_of :item_quantity}
  end
  describe 'relationships' do
    it {should belong_to :merchant}
  end

  describe 'methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)

      @off_2 = Discount.create(percentage_discount: 10, item_quantity: 2, merchant_id: @megan.id)
      @off_20_for_2 = Discount.create(percentage_discount: 20, item_quantity: 2, merchant_id: @megan.id)
    end
    
    it '.best_discount' do
      expect(Discount.best_discount).to eq(20)
    end
  end
end
