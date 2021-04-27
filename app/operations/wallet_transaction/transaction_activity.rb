require 'pry'

module WalletTransaction
    class TransactionActivity
        def initialize(amount, type, source_account = nil, recipient_account = nil)
          @amount = amount.to_f
          @source_account = source_account
          @recipient_account = recipient_account
          @type = type
        end

        def perform
          ActiveRecord::Base.transaction do
            AccountTransaction.create!(
              amount: @amount,
              origin: @source_account,
              recipient: @recipient_account,
              transaction_type: @type
            )

            if @type == 'withdraw'
              @source_account.update!(balance: @source_account.balance.to_f - @amount)
            elsif @type == 'deposit'
              @recipient_account.update!(balance: @recipient_account.balance.to_f + @amount)
            else
              @source_account.update!(balance: @source_account.balance.to_f - @amount)
              @recipient_account.update!(balance: @recipient_account.balance.to_f + @amount)
            end
          end
        rescue StandardError => e
          e.message
        end
    end
end