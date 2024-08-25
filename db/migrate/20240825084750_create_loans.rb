class CreateLoans < ActiveRecord::Migration[7.2]
  def change
    create_table :loans do |t|
      t.integer :state
      t.decimal :principal_amount
      t.decimal :interest_rate
      t.decimal :interest_amount
      t.integer :user_id
      t.datetime :next_interest_time
      t.string :closing_remarks

      t.timestamps
    end
  end
end
