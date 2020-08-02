require 'rails_helper'

RSpec.describe "discounts index page" do
  describe "from the merchants dashboard, there is a link to that merchants discounts"  do
    before :each do
      @merchant1 = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 2, merchant_id: @merchant1.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @off_10 = Discount.create(percentage_discount: 10, item_quantity: 10, merchant_id: @merchant1.id)

      @off_20 = Discount.create(percentage_discount: 20, item_quantity: 20, merchant_id: @merchant1.id)
    end

    it "where all discounts for that merchant are displayed" do
      visit "/merchant"

      click_on "My Discounts"

      expect(current_path).to eq("/merchant/discounts")

      within(".discount-#{@off_10.id}") do
        expect(page).to have_content("Percentage Discount: 10%")
        expect(page).to have_content("Item Quantity: 10 items")
      end

      within(".discount-#{@off_20.id}") do
        expect(page).to have_content("Percentage Discount: 20%")
        expect(page).to have_content("Item Quantity: 20 items")
      end

      within(".discount-#{@off_10.id}") do
        click_on "Discount #{@off_10.id}"
      end

      expect(current_path).to eq("/merchant/discounts/#{@off_10.id}")
    end
  end
end
