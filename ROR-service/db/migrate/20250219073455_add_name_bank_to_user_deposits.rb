class AddNameBankToUserDeposits < ActiveRecord::Migration[7.1]
  def change
    add_column :user_deposits, :name_bank, :string
  end
end
