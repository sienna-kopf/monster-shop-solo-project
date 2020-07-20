require 'rails_helper'

RSpec.describe "form to fill out a new user" do
  it "can fill out a form to register as a new user" do
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
