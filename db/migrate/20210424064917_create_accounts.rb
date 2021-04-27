class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.integer :account_type
      t.decimal :balance, precision: 15, scale: 2, default: 0.00, null: false
      t.string :account_number
      t.integer :owner_id
      t.string :owner_type
      t.string :currency
      t.index %i[owner_type owner_id], name: 'index_accounts_on_owner_type_and_owner_id'
      t.index %i[account_number], name: 'index_accounts_on_account_number', unique: true

      t.timestamps
    end
  end
end