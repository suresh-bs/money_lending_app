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

  after_update :transfer_amount_if_open

  private

  def transfer_amount_if_open
    if open?
      trasfer_amount
    end
  end

  def trasfer_amount
    admin = User.admin.first
    admin.wallet.update(amount: admin.wallet.amount - principal_amount)
    user.wallet.update(amount: user.wallet.amount + principal_amount)
  end
end