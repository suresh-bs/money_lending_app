class Client::LoansController < ApplicationController

  def index
    @loans = current_user.loans
  end

  def new
    @loan = current_user.loans.build
  end

  def create
    @loan = current_user.loans.build(loan_params)
    if @loan.save
      redirect_to client_loans_path
    else
      render :new
    end
  end

  def edit
    @loan = current_user.loans.find(params[:id])
  end

  def update
    @loan = Loan.find(params[:id])
    @loan.update(loan_params.merge(state: :readjustment_requested))
    redirect_to edit_client_loan_path(@loan)
  end

  def confirm
    @loan = current_user.loans.find(params[:id])
    @loan.trasfer_amount!
    @loan.open!
    redirect_to edit_client_loan_path(@loan)
  end

  def reject
    @loan = current_user.loans.find(params[:id])
    @loan.rejected!
    redirect_to edit_client_loan_path(@loan)
  end

  def repay
    @loan = current_user.loans.find(params[:id])
    @loan.repaid!
    @loan.closed!
    redirect_to edit_client_loan_path(@loan)
  end

  private
  def loan_params
    params.require(:loan).permit(:principal_amount, :interest_rate)
  end
end