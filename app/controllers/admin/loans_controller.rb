class Admin::LoansController < ApplicationController

  def index
    @loans = Loan.all
  end

  def edit
    @loan = Loan.find(params[:id])
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
end