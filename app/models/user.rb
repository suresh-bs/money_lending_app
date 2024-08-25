class User < ApplicationRecord
  has_one :wallet, dependent: :destroy
  has_many :loans, dependent: :destroy
  has_many :loan_event_logs

  has_secure_password
  enum :role, { :client => 0, :admin => 1 }

  validates :email, presence: true, uniqueness: true

  after_create :create_wallet

  private

  def create_wallet
    Wallet.create(user_id: id, amount: admin? ? 1000000 : 10000)
  end
end