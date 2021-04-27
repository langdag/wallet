class CreateAccountTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :account_transactions do |t|
      t.decimal :amount
      t.integer :transaction_type
      t.integer :origin_account_id
      t.integer :recipient_account_id
      t.index %i[origin_account_id], name: 'index_account_transactions_on_origin_account_id'
      t.index %i[recipient_account_id], name: 'index_account_transactions_on_recipient_account_id'

      t.timestamps
    end
  end
end