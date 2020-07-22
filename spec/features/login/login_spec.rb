require "rails_helper"

RSpec.describe "User login" do
  describe "regular user logs in" do
    it "redirects to profile page and displays flash message" do
      user = User.create(name: "Tim", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "1234@gmail.com", password: "password", role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/login"

      fill_in :email, with: "1234@gmail.com"
      fill_in :password, with: "password"

      click_on "Log In"

      expect(current_path).to eq("/profile")
      expect(page).to have_content("You are now successfully logged in as #{user.name}")
    end
  end
  describe "merchant user logs in" do
    it "redirects to merchant dashboard page and displays flash message" do
      user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/login"

      fill_in :email, with: "12345@gmail.com"
      fill_in :password, with: "password"

      click_on "Log In"

      expect(current_path).to eq("/merchant/dashboard")
      expect(page).to have_content("You are now successfully logged in as #{user.name}")
    end
  end
  describe "admin user logs in" do
    it "redirects to admin dashboard page and displays flash message" do
      user = User.create(name: "Kat", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "123456@gmail.com", password: "password", role: 3)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/login"

      fill_in :email, with: "123456@gmail.com"
      fill_in :password, with: "password"

      click_on "Log In"

      expect(current_path).to eq("/admin/dashboard")
      expect(page).to have_content("You are now successfully logged in as #{user.name}")
    end
  end
end
