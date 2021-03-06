require 'rails_helper'

RSpec.describe "when a user goes to checkout" do
  describe "if any of the items in their cart qualify for a discount" do
    before :each do
      @merchant1 = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @merchant2 = Merchant.create(name: "Josh's Hold Shop", address: '123 Climbing Rd.', city: 'Denver', state: 'CO', zip: 80403)

      @off_10 = Discount.create(percentage_discount: 10, item_quantity: 10, merchant_id: @merchant1.id)
      @off_20 = Discount.create(percentage_discount: 20, item_quantity: 15, merchant_id: @merchant1.id)

      @user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

      @tire = @merchant1.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @merchant1.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 30)
      @pencil = @merchant1.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

      @bluepill = @merchant2.items.create(name: "Blue Pill Volume", description: "Best hold on the market", price: 70, image: "https://i0.wp.com/www.bluepill-climbing.com/wp-content/uploads/2016/06/fat-square-600-2-1.jpg?fit=600%2C400&ssl=1", inventory: 25)
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
      end

      within("#cart-item-#{@pencil.id}") do
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
      end

      visit "/cart"

      within "#cart-item-#{@paper.id}" do
        expect(page).to have_link(@paper.name)
        expect(page).to have_css("img[src*='#{@paper.image}']")
        expect(page).to have_link("#{@paper.merchant.name}")
        expect(page).to have_content("$20.00")
        expect(page).to have_content("8")
        expect(page).to have_content("$160.00")
      end

      within "#cart-item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_link("#{@tire.merchant.name}")
        expect(page).to have_content("$100.00")
        expect(page).to have_content("4")
        expect(page).to have_content("$400.00")
      end

      within "#cart-item-#{@pencil.id}" do
        expect(page).to have_link(@pencil.name)
        expect(page).to have_css("img[src*='#{@pencil.image}']")
        expect(page).to have_link("#{@pencil.merchant.name}")
        expect(page).to have_content("$2.00")
        expect(page).to have_content("6")
        expect(page).to have_content("$12.00")
      end

      expect(page).to have_content("Total: $572.00")

      visit '/cart'

      within("#cart-item-#{@paper.id}") do
        click_on "Increase Amount"
        click_on "Increase Amount"
      end

      within "#cart-item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_link("#{@tire.merchant.name}")
        expect(page).to have_content("$100.00")
        expect(page).to have_content("4")
        expect(page).to have_content("$400.00")
      end

      within "#cart-item-#{@pencil.id}" do
        expect(page).to have_link(@pencil.name)
        expect(page).to have_css("img[src*='#{@pencil.image}']")
        expect(page).to have_link("#{@pencil.merchant.name}")
        expect(page).to have_content("$2.00")
        expect(page).to have_content("6")
        expect(page).to have_content("$12.00")
      end

      within "#cart-item-#{@paper.id}" do
        expect(page).to have_link(@paper.name)
        expect(page).to have_css("img[src*='#{@paper.image}']")
        expect(page).to have_link("#{@paper.merchant.name}")
        expect(page).to have_content("$18.00")
        expect(page).to have_content("Item price has been adjusted due to discount!")
        expect(page).to have_content("10")
        expect(page).to have_content("$180.00")
        expect(page).to have_content("Discount of 10% off 10 items has been applied to #{@paper.name}")
      end

      expect(page).to have_content("Total: $592.00")
    end

    it "if two discounts apply, it chooses the better one" do
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"

      visit "/cart"

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

      within "#cart-item-#{@paper.id}" do
        expect(page).to have_link(@paper.name)
        expect(page).to have_css("img[src*='#{@paper.image}']")
        expect(page).to have_link("#{@paper.merchant.name}")
        expect(page).to have_content("$18.00")
        expect(page).to have_content("Item price has been adjusted due to discount!")
        expect(page).to have_content("10")
        expect(page).to have_content("$180.00")
        expect(page).to have_content("Discount of 10% off 10 items has been applied to #{@paper.name}")
      end

      expect(page).to have_content("Total: $180.00")

      within("#cart-item-#{@paper.id}") do
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
        click_on "Increase Amount"
      end

      within "#cart-item-#{@paper.id}" do
        expect(page).to have_link(@paper.name)
        expect(page).to have_css("img[src*='#{@paper.image}']")
        expect(page).to have_link("#{@paper.merchant.name}")
        expect(page).to have_content("$16.00")
        expect(page).to have_content("Item price has been adjusted due to discount!")
        expect(page).to have_content("15")
        expect(page).to have_content("$240.00")
        expect(page).to have_content("Discount of 20% off 15 items has been applied to #{@paper.name}")
      end

      expect(page).to have_content("Total: $240.00")
    end

    it "discounts do not apply to items in the cart not from that merchant" do
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@bluepill.id}"
      click_on "Add To Cart"

      visit "/cart"

      within("#cart-item-#{@bluepill.id}") do
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


      within "#cart-item-#{@bluepill.id}" do
        expect(page).to have_link(@bluepill.name)
        expect(page).to have_css("img[src*='#{@bluepill.image}']")
        expect(page).to have_link("#{@bluepill.merchant.name}")
        expect(page).to have_content("$70.00")
        expect(page).to have_content("10")
        expect(page).to have_content("$700.00")

        expect(page).to_not have_content("Item price has been adjusted due to discount!")
      end
    end
  end
end
