class LoanEventLog < ApplicationRecord
  belongs_to :loan
  belongs_to :user

  enum :state, { requested: 0,
                  approved: 1,
                  open: 2,
                  closed: 3,
                  rejected: 4,
                  waiting_for_adjustment_acceptance: 5,
                  readjustment_requested: 6 }

  def state_text
    state.split('_')
          .map(&:capitalize)
          .join(' ')
  end
end