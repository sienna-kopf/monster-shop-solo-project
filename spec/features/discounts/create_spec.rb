require 'rails_helper'

RSpec.describe "from the discounts index page" do
  describe "there is a link to a form to create a new discount"  do
    before :each do
      @merchant1 = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 2, merchant_id: @merchant1.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @off_10 = Discount.create(percentage_discount: 10, item_quantity: 10, merchant_id: @merchant1.id)

      @off_20 = Discount.create(percentage_discount: 20, item_quantity: 20, merchant_id: @merchant1.id)
    end

    it "saves the new discount and displays it on the discount index page" do
      visit "/merchant/discounts"

      click_on "Create New Discount"

      expect(current_path).to eq("/merchant/discounts/new")

      fill_in :percentage_discount, with: 30
      fill_in :item_quantity, with: 30

      click_on "Add Discount"

      new_discount = Discount.last

      expect(current_path).to eq("/merchant/discounts")
      expect(page).to have_content("Discount has successfully been created!")

      within(".discount-#{new_discount.id}") do
        expect(page).to have_content("Percentage Discount: 30%")
        expect(page).to have_content("Item Quantity: 30 items")
        expect(page).to have_link("Discount #{new_discount.id}")
      end
    end

    it "relays error messages when form is sumbitted incomplete" do
      visit "/merchant/discounts"

      click_on "Create New Discount"

      expect(current_path).to eq("/merchant/discounts/new")

      fill_in :percentage_discount, with: ""
      fill_in :item_quantity, with: ""

      click_on "Add Discount"

      expect(current_path).to eq("/merchant/discounts/new")
      expect(page).to have_content("Percentage discount can't be blank")
      expect(page).to have_content("Item quantity can't be blank")
    end
  end
end
