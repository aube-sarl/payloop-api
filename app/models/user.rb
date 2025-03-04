class User < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :middle_name, presence: true
  vaildates :email, presence: true
  validates :phone_number, presence: true
end
