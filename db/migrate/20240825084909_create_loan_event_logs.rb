class CreateLoanEventLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :loan_event_logs do |t|
      t.integer :state
      t.decimal :principal_amount
      t.decimal :interest_rate
      t.integer :loan_id
      t.integer :user_id

      t.timestamps
    end
  end
end
