require 'sidekiq-scheduler'

class LoanWorker
  include Sidekiq::Worker

  def perform
    admin_wallet = User.admin.first.wallet
    Loan.open.find_each do |loan|
      user_wallet = loan.user.wallet
      if loan.next_interest_time <= Time.zone.now
        loan.next_interest_time = loan.next_interest_time + 5.minutes
        interest = loan.principal_amount * loan.interest_rate / 100
        loan.interest_amount = loan.interest_amount + interest
        loan.save
      end
      if loan.total_amount_to_pay > user_wallet.amount
        admin_wallet.update(amount: admin_wallet.amount + user_wallet.amount)
        user_wallet.update(amount: 0)
        loan.closed!
      end
    end
  end
end