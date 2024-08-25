class Loan < ApplicationRecord
  belongs_to :user
  has_many :loan_event_logs, dependent: :destroy

  enum :state, { requested: 0,
                  approved: 1,
                  open: 2,
                  closed: 3,
                  rejected: 4,
                  waiting_for_adjustment_acceptance: 5,
                  readjustment_requested: 6 }

end