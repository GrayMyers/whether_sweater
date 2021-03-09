class User < ApplicationRecord
  attr_accessor :password_confirmation
  has_secure_password

  validates :email, uniqueness: true, presence:true
  validates :password, presence: true

  validates :password_confirmation, presence: true
  validates_confirmation_of :password
end
