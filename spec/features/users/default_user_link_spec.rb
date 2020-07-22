require 'rails_helper'

RSpec.describe "as a default user" do
  describe "it views any page" do
    it "and sees links to profile and log out, does not see link to log in or register and says logged in message" do
      user = User.create(name: "Nick", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"

      expect(page).to have_link("Log Out")
      expect(page).to have_link("Profile")
      expect(page).to_not have_link("Login")
      expect(page).to_not have_link("Register")

      expect(page).to have_content("Logged in as #{user.name}")
    end
  end


  describe "I try to view pages starting with /merchant or /admin" do
    it "it displays a 404 error" do
      default_user = User.create(name: "Tim", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(default_user)

      visit "/merchant/dashboard"
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit "/admin/users"
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit "/admin/dashboard"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
