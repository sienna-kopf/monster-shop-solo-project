require 'rails_helper'

RSpec.describe "default user show page" do
  describe "the registered user visits their show page" do
    it "can see all profile data except password and a link to edit the profile data" do
      user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/profile"

      expect(page).to have_content("Megan")
      expect(page).to have_content("Address: 123 North st")
      expect(page).to have_content("City: Denver")
      expect(page).to have_content("State: Colorado")
      expect(page).to have_content("Zip code: 80401")
      expect(page).to have_content("Email: 12345@gmail.com")

      expect(page).to have_link("Edit Profile")
    end
  end
end
