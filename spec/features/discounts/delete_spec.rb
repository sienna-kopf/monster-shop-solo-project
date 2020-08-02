require 'rails_helper'

RSpec.describe "on the discounts show page" do
  describe "there is a link to delete that discount"  do
    before :each do
      @merchant1 = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 2, merchant_id: @merchant1.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @off_10 = Discount.create(percentage_discount: 10, item_quantity: 10, merchant_id: @merchant1.id)

      @off_20 = Discount.create(percentage_discount: 20, item_quantity: 20, merchant_id: @merchant1.id)
    end

    it "and in doing so, that discount is removed and cannot be viewed" do
      visit "/merchant/discounts/#{@off_20.id}"

      expect(page).to have_content("Percentage Discount: 20%")
      expect(page).to have_content("Item Quantity: 20 items")

      click_on "Delete Discount"

      expect(page).to have_content("Discount has been successfully deleted!")
      expect(current_path).to eq("/merchant/discounts")
      
      expect(page).to_not have_content("Percentage Discount: 20%")
      expect(page).to_not have_content("Item Quantity: 20 items")
    end
  end
end
