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

  describe "failed login" do
    describe "established user inputs bad credentials into login form" do
      it "displays a flash message and redirects user to login page" do
        user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 2)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit "/login"

        fill_in :email, with: "12345@gmail.com"
        fill_in :password, with: "not_the_right_pass"

        click_on "Log In"

        expect(page).to have_content("Bad Credentials. Try Again!")
        expect(current_path).to eq("/login")
      end

      it "displays a flash message and redirects user to login page" do
        user = User.create(name: "Megan", address: "123 North st", city: "Denver", state: "Colorado", zip: "80401", email: "12345@gmail.com", password: "password", role: 2)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit "/login"

        fill_in :email, with: "1999@gmail.com"
        fill_in :password, with: "password"

        click_on "Log In"

        expect(page).to have_content("Bad Credentials. Try Again!")
        expect(current_path).to eq("/login")
      end
    end

    describe "visitor tries to login without registering" do
      it "displays a flash message and redirects user to login page" do
        visit "/login"

        fill_in :email, with: "dfaihdsuifghuoaiwe"
        fill_in :password, with: "dfhkasdhfud"

        click_on "Log In"

        expect(page).to have_content("You must have an account to log in!")
        expect(current_path).to eq("/login")
      end
    end
  end
end
