class User < ApplicationRecord
  EMAIL_PATTERN = /\A[^@\s]+@[^@\s]+\z/

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_PATTERN, allow_blank: true }
end
