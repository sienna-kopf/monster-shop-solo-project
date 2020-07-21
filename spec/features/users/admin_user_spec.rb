require 'rails_helper'

RSpec.describe "as an admin level user" do
  describe "it views any page" do
    it "and sees additonal link to admin dashboard" do
      user = User.create(name: "Rachel", role: 3)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"

      expect(page).to have_link("Dashboard")
      click_on "Dashboard"
      expect(current_path).to eq("/admin/dashboard")

      expect(page).to have_link("All Users")
      click_on "All Users"
      expect(current_path).to eq("/admin/users")

      expect(page).to_not have_link("Cart: 0")
    end

    it "a non-admin cannot see admin " do
      user = User.create(name: "Bob", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"

      expect(page).to_not have_link("Dashboard")
      expect(page).to_not have_link("All Users")
    end
  end
end
