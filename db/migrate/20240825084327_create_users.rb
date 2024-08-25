class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :email
      t.integer :role
      t.string :password_digest

      t.timestamps
    end
  end
end
