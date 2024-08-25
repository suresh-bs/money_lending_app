class Loan < ApplicationRecord
  belongs_to :user
  has_many :loan_event_logs

end