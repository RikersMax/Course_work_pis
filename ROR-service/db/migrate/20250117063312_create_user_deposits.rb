class CreateUserDeposits < ActiveRecord::Migration[7.1]
  def change
    create_table :user_deposits do |t|
      t.integer :id_product
      t.string :name_product
      t.string :title_vklad
      t.float :rate
      t.decimal :amount_miney
      t.integer :month_count
      t.boolean :deposit
      t.boolean :withdrawal
      t.references :user, null: false, foreign_key: true
      t.date :deposit_start
      t.date :deposit_end

      t.timestamps
    end
  end
end
