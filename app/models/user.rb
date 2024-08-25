class User < ApplicationRecord
  has_one :wallet
  has_many :loans
  has_many :loan_event_logs

  enum role: { user: 0, admin: 1 }

  validates :email, presence: true, uniqueness: true
end