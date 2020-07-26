require 'rails_helper'

RSpec.describe "as a merchant level user" do
  describe "it views any page" do
    it "and sees additonal link to merchant dashboard" do
      merchant = User.create(name: "Timmy", role: 2)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant)

      visit "/"

      expect(page).to have_link("Dashboard")
      click_on "Dashboard"
      expect(current_path).to eq("/merchant")
    end

    it "does not see link to merchant dashboard when logged in as default user" do
      user = User.create(name: "Bob", role: 1)

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
end
