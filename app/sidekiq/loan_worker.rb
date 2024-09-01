class LoanWorker
  include Sidekiq::Worker

  def perform
    Loan.open.find_each do |loan|
      if loan.next_interest_time <= Time.zone.now
        loan.next_interest_time = loan.next_interest_time + 5.minutes
        interest = loan.principal_amount * loan.interest_rate / 100
        loan.interest_amount = loan.interest_amount + interest
        loan.save
      end
    end
  end
end