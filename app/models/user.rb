class User < ApplicationRecord
  has_one :wallet
  has_many :loans
  has_many :loan_event_logs

end