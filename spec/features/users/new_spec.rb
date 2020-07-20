require 'rails_helper'

RSpec.describe "as a new user" do
  describe "it can fill out a form to register" do
    it "fills in all fields" do
      visit "/register/new"

      fill_in :name, with: "Nick E."
      fill_in :address, with: "123 Maine St."
      fill_in :city, with: "Denver"
      fill_in :state, with: "Colorado"
      fill_in :zip, with: "80218"
      fill_in :email, with: "123@gmail.com"
      fill_in :password, with: "secure-password"
      fill_in :password_confirmation, with: "secure-password"

      click_on "Register User"

      expect(current_path).to eq("/profile")

      expect(page).to have_content("Nick E.")
      expect(page).to have_content("Address: 123 Maine St.")
      expect(page).to have_content("City: Denver")
      expect(page).to have_content("State: Colorado")
      expect(page).to have_content("Zip code: 80218")
      expect(page).to have_content("Email: 123@gmail.com")
      expect(page).to have_content("Hello, Nick E. You are now registered and logged in")

      within 'nav' do
        expect(page).to have_content("Log Out")
        expect(page).to_not have_content("Login")
      end
    end
  end

  describe "it can\'t fill in a form with missing fields" do
    it 'it leaves fields blank' do

      visit "/register/new"

      click_on "Register User"
      expect(current_path).to eq("/register/new")

      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Address can't be blank")
      expect(page).to have_content("City can't be blank")
      expect(page).to have_content("State can't be blank")
      expect(page).to have_content("Zip can't be blank")
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")
    end
  end
end
