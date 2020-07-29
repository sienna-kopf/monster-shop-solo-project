class User < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  validates_format_of :zip,
                with: /\A\d{5}-\d{4}|\A\d{5}\z/,
                message: "should be 12345 or 12345-1234"
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :password, require: true
  has_secure_password
  has_many :orders

  enum role: %w(visitor default merchant admin)
end
