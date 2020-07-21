require 'rails_helper'

RSpec.describe "as a merchant level user" do
  describe "it views any page" do
    it "and sees additonal link to merchant dashboard" do
      user = User.create(name: "Timmy", role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/"

      expect(page).to have_link("Dashboard")
    end

    it "does not see link to merchant dashboard when logged in as default user" do
      user = User.create(name: "Bob", role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      
      visit "/"

      expect(page).to_not have_link("Dashboard")
    end
  end
end
