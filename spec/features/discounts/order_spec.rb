require 'rails_helper'

RSpec.describe "when a user clicks on checkout" do
  describe "They are taken to the orders new page and any discounts are shown" do
    before :each do
      @merchant1 = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @off_10 = Discount.create(percentage_discount: 10, item_quantity: 10, merchant_id: @merchant1.id)
      @off_20 = Discount.create(percentage_discount: 20, item_quantity: 20, merchant_id: @merchant1.id)

      @user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @tire = @merchant1.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @merchant1.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 30)
      @pencil = @merchant1.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
    end

    it "automatically applies that discount" do
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@tire.id}"
      click_on "Add To Cart"
      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"

      visit "/cart"

      within("#cart-item-#{@tire.id}") do
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
      end

      within("#cart-item-#{@paper.id}") do
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
      end

      within("#cart-item-#{@pencil.id}") do
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
      end

       click_on "Checkout"

       expect(current_path).to eq("/orders/new")

       within "#order-item-#{@tire.id}" do
         expect(page).to have_link(@tire.name)
         expect(page).to have_link("#{@tire.merchant.name}")
         expect(page).to have_content("$100.00")
         expect(page).to have_content("4")
         expect(page).to have_content("$400.00")
       end

       within "#order-item-#{@paper.id}" do
         expect(page).to have_link(@paper.name)
         expect(page).to have_link("#{@paper.merchant.name}")
         expect(page).to have_content("$18.00")
         expect(page).to have_content("Item price has been adjusted due to discount!")
         expect(page).to have_content("10")
         expect(page).to have_content("$180.00")
         expect(page).to have_content("Discount of 10% off 10 items has been applied to #{@paper.name}")
       end

       within "#order-item-#{@pencil.id}" do
         expect(page).to have_link(@pencil.name)
         expect(page).to have_link("#{@pencil.merchant.name}")
         expect(page).to have_content("$2.00")
         expect(page).to have_content("6")
         expect(page).to have_content("$12.00")
       end

       expect(page).to have_content("Total: $592")

       expect(page).to have_field(:name)
       expect(page).to have_field(:address)
       expect(page).to have_field(:city)
       expect(page).to have_field(:state)
       expect(page).to have_field(:zip)
       expect(page).to have_button("Create Order")
    end
  end
end
