class AddResultMoneyToUserDeposits < ActiveRecord::Migration[7.1]
  def change
    add_column :user_deposits, :result_money, :decimal
  end
end
