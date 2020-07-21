require 'rails_helper'

RSpec.describe "as a defauly user" do
  describe "it views any page" do
    it "and sees links to profile and log out, does not see link to log in or register and says logged in message" do
      user = User.create(name: "Nick", role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"

      expect(page).to have_link("Log Out")
      expect(page).to have_link("Profile")
      expect(page).to_not have_link("Login")
      expect(page).to_not have_link("Register")

      expect(page).to have_content("Logged in as #{user.name}")
    end
  end
end
