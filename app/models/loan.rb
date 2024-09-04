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

  before_save :assign_next_interest_time
  after_save :create_loan_event_log

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

  def state_text
    state.split('_')
         .map(&:capitalize)
         .join(' ')
  end

  def tenure_limit
    amount = principal_amount
    i_amount = principal_amount * interest_rate / 100
    term = 0
    loop do
      term += 1
      amount = amount + i_amount
      break if amount > user.wallet.amount
    end
    term
  end

  private

  def assign_next_interest_time
    if open?
      self.next_interest_time ||= Time.zone.now + 5.minutes
    end
  end

  def create_loan_event_log
    loan_event_logs.create(state: state, principal_amount: principal_amount, interest_rate: interest_rate, user_id: user_id)
  end
end