require 'rails_helper'

RSpec.describe "from a discounts show page" do
  describe "there is a link to a form to update that discount"  do
    before :each do
      @merchant1 = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 2, merchant_id: @merchant1.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @off_10 = Discount.create(percentage_discount: 10, item_quantity: 10, merchant_id: @merchant1.id)

      @off_20 = Discount.create(percentage_discount: 20, item_quantity: 20, merchant_id: @merchant1.id)
    end

    it "saves the changes and displays them accordingly" do
      visit "/merchant/discounts/#{@off_20.id}"

      click_on "Update Discount"

      expect(current_path).to eq("/merchant/discounts/#{@off_20.id}/edit")

      fill_in :percentage_discount, with: 30
      fill_in :item_quantity, with: 30

      click_on "Update Discount"

      expect(current_path).to eq("/merchant/discounts/#{@off_20.id}")
      expect(page).to have_content("Discount has been successfully updated!")

      expect(page).to have_content("Percentage Discount: 30%")
      expect(page).to have_content("Item Quantity: 30 items")
    end

    it "relays error messages when form is sumbitted incomplete" do
      visit "/merchant/discounts/#{@off_20.id}"

      click_on "Update Discount"

      expect(current_path).to eq("/merchant/discounts/#{@off_20.id}/edit")

      fill_in :percentage_discount, with: ""
      fill_in :item_quantity, with: ""

      click_on "Update Discount"

      expect(current_path).to eq("/merchant/discounts/#{@off_20.id}/edit")
      expect(page).to have_content("Percentage discount can't be blank")
      expect(page).to have_content("Item quantity can't be blank")
    end
  end
end
