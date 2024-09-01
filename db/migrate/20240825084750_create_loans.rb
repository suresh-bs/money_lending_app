class CreateLoans < ActiveRecord::Migration[7.2]
  def change
    create_table :loans do |t|
      t.integer :state, default: 0
      t.decimal :principal_amount, default: 0
      t.decimal :interest_rate, default: 0
      t.decimal :interest_amount, default: 0
      t.integer :user_id
      t.datetime :next_interest_time
      t.string :closing_remarks

      t.timestamps
    end
  end
end
