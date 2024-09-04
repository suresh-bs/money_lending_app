class Admin::LoansController < ApplicationController

  def index
    @loans = Loan.all
  end

  def edit
    @loan = Loan.find(params[:id])
  end

  def update
    @loan = Loan.find(params[:id])
    @loan.update(loan_params.merge(state: :waiting_for_adjustment_acceptance))
    redirect_to edit_admin_loan_path(@loan)
  end

  def reject
    @loan = Loan.find(params[:id])
    @loan.rejected!
    redirect_to edit_admin_loan_path(@loan)
  end

  def approve
    @loan = Loan.find(params[:id])
    @loan.approved!
    redirect_to edit_admin_loan_path(@loan)
  end

  private
  def loan_params
    params.require(:loan).permit(:principal_amount, :interest_rate)
  end
end