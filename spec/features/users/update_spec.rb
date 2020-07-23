require "rails_helper"

RSpec.describe "a default user" do
  it "can update their profile data" do
    user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/profile"

    click_on "Edit Profile"

    expect(current_path).to eq("/users/edit")

    expect(page).to have_field(:name, with: 'Megan')
    expect(page).to have_field(:address, with: '123 North st')
    expect(page).to have_field(:city, with: 'Denver')
    expect(page).to have_field(:state, with: 'Colorado')
    expect(page).to have_field(:zip, with: '80401')
    expect(page).to have_field(:email, with: "12345@gmail.com")

    fill_in :name, with: "Tim"
    fill_in :city, with: "Salt Lake City"
    fill_in :state, with: "Utah"
    fill_in :zip, with: "80444"

    click_on "Update Profile"

    expect(current_path).to eq("/profile")

    expect(page).to have_content("Tim")
    expect(page).to_not have_content("Megan")
    expect(page).to have_content("Salt Lake City")
    expect(page).to_not have_content("Denver")
    expect(page).to have_content("Utah")
    expect(page).to_not have_content("Colorado")
    expect(page).to have_content("80444")
    expect(page).to_not have_content("80401")

    expect(page).to have_content("Email: 12345@gmail.com")
    expect(page).to have_content("Address: 123 North st")

    expect(page).to have_content("Information successfully updated.")
  end

  it "can update password" do
    user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/profile"

    click_on "Edit Password"

    expect(current_path).to eq("/users/password/edit")

    expect(page).to have_field(:current_password)

    expect(page).to have_field(:new_password)
    expect(page).to have_field(:new_password_confirmation)

    fill_in :current_password, with: "password"

    fill_in :new_password, with: "secure-password"
    fill_in :new_password_confirmation, with: "secure-password"

    click_on "Update Password"

    expect(current_path).to eq("/profile")

    expect(page).to have_content("Password successfully updated.")
    # 
    # visit "/logout"
    #
    # visit "/login"
    #
    # fill_in :email, with: "12345@gmail.com"
    # fill_in :password, with: "secure-password"
    #
    # click_on "Log In"
    #
    # expect(current_path).to eq("/profile")
  end
end
