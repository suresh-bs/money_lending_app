class Admin::LoansController < ApplicationController

  def index
    @loans = Loan.all
  end
end