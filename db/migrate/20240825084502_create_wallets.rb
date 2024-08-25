class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.decimal :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
