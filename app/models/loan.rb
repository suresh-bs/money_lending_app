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

  before_create :assign_next_interest_time

  def repaid!
    admin = User.admin.first
    admin.wallet.update(amount: admin.wallet.amount + total_amount_to_pay)
    user.wallet.update(amount: user.wallet.amount - total_amount_to_pay)
  end

  def total_amount_to_pay
    @total_amount_to_pay ||= principal_amount + interest_amount
  end

  def trasfer_amount!
    admin = User.admin.first
    admin.wallet.update(amount: admin.wallet.amount - principal_amount)
    user.wallet.update(amount: user.wallet.amount + principal_amount)
  end

  private

  def assign_next_interest_time
    self.next_interest_time ||= Time.zone.now + 5.minutes
  end
end