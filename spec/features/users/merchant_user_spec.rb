require 'rails_helper'

RSpec.describe "as a merchant level user" do
  describe "it views any page" do
    it "and sees additonal link to merchant dashboard" do
      merchant1 = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 2, merchant_id: merchant1.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"

      expect(page).to have_link("Dashboard")
      click_on "Dashboard"
      expect(current_path).to eq("/merchant")
    end

    it "does not see link to merchant dashboard when logged in as default user" do
      user = User.create(name: "Bob", role: 1)
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"

      expect(page).to_not have_link("Dashboard")
    end
  end

  describe "I try to view pages starting with /admin" do
    it "it displays a 404 error" do
      merchant = User.create(name: "Sarah", role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit "/admin/users"
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit "/admin"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe "it visits its dashboard" do
    it "can see the merchant it works for" do
      merchant1 = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 2, merchant_id: merchant1.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/merchant"

      expect(page).to have_content("#{merchant1.name}")
      expect(page).to have_content("#{merchant1.address}")

    end
  end
end
