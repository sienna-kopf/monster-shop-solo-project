require 'rails_helper'

RSpec.describe "as a visitor" do
  describe "I try to view pages starting with /merchant, /admin, /profile" do
    it "displays a 404 error" do
      visit "/merchant"
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit "/admin/users"
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit "/admin"
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit "/profile"
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
