class CreateUserDeposits < ActiveRecord::Migration[7.1]
  def change
    create_table :user_deposits do |t|
      t.references :user, null: false, foreign_key: true          
      t.string :deposit_title 
      t.decimal :rate # ставка
      t.decimal :amount_money # сумма в рублях
      t.integer :term_in_days #кол-во дней
      t.boolean :deposit #пополнение
      t.boolean :withdrawal #снятие
      t.date :deposit_start
      t.date :deposit_end
      t.index [:user_id, :deposit_title, :rate], unique: true
      t.timestamps
    end
  end
end
