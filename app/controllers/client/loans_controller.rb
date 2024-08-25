class Client::LoansController < ApplicationController

  def index
    @loans = current_user.loans
  end
end