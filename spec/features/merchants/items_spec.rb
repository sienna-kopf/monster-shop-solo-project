require 'rails_helper'

RSpec.describe "As a merchant user" do
  before(:each) do
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 2, merchant_id: @meg.id)

    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @pull_toy = @meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
    @dog_bone = @meg.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
  end

  describe "When I visit the items index page" do
    it "I can disable an item" do
      visit "/merchant/items"

      expect("#{@tire.active?}").to eq('true')

      expect(page).to have_content("#{@tire.name}")
      expect(page).to have_content("#{@tire.description}")
      expect(page).to have_content("#{@tire.price}")
      expect(page).to have_css("img[src*='#{@tire.image}']")
      expect(page).to have_content("Active")
      expect(page).to have_content("#{@tire.inventory}")
      expect(page).to have_button("Deactivate")
      expect(page).to_not have_content("Activate")

      within "#item-#{@tire.id}" do
        click_on "Deactivate"
      end

      expect(current_path).to eq("/merchant/items")

      expect(page).to have_content("#{@tire.name} is no longer for sale")

      @meg.items.all? {|item| item.active? == false}
    end

    it "I see a button to activate inactive items," do

      visit "/merchant/items"

      within "#item-#{@tire.id}" do
        click_on "Deactivate"
      end
      expect(current_path).to eq("/merchant/items")

      within "#item-#{@tire.id}" do
        click_on "Activate"
      end

      expect(current_path).to eq("/merchant/items")

      @meg.items.all? {|item| item.active? == true}

      expect(page).to have_content("#{@tire.name} is now for sale")

    end

    it "can delete items that have not been ordered" do
      order_4 = Order.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'NC', zip: 17033, status: "cancelled", user_id: @user.id)

      order_4.item_orders.create!(item: @dog_bone, price: @dog_bone.price, quantity: 9)

      visit "/merchant/items"

      within(".delete-item-#{@tire.id}") do
        expect(page).to have_button("delete")
      end

      within "#item-#{@dog_bone.id}" do
        expect(page).to_not have_button("delete")
      end

      within "#item-#{@pull_toy.id}" do
        click_button "delete"

        expect(current_path).to eq("/merchant/items")
      end

      expect(page).to have_content("#{@pull_toy.name} was sucessfully deleted")

      expect(page).to_not have_content("Great pull toy!")
      expect(page).to_not have_content("#{@pull_toy.id}")

    end
  end
end
