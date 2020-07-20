require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip)}
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
  end

  describe 'methods' do
    xit '#current_user' do
      @user = User.create(name: "Nick E.", address: "123 Maine St.", city: "Denver", state: "Colorado", zip: "80218", email: "123@gmail.com", password: "secure-password", password_confirmation: "secure-password")
      session = Capybara::Session.new(@user)
      session = @user.id
      expect(@user.current_user).to eq(true)
    end
  end
end
