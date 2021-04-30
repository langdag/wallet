require 'pry'

module WalletTransaction
    class ValidateTransaction
        def initialize(amount, type, source_account = nil, recipient_account = nil)
            @amount = amount
            @type = type
            @source_account = source_account
            @recipient_account = recipient_account
            @errors = []
        end
        
        def perform
            validate_accounts
            validate_withdrawal if @type == "withdraw" && @source_account.present?
            validate_transfer if @type == "transfer"
            validate_amount
            @errors
        end

        def validate_withdrawal
            @errors << "Insufficient funds" if @amount.to_f > @source_account.balance.to_f
        end

        def validate_accounts
            @errors << "Source Wallet is Invalid" unless @source_account.present?
            @errors << "Recipient Wallet is Invalid" unless @recipient_account.present? || @type == "withdraw"
        end

        def validate_transfer
            if @source_account.present? && @recipient_account.present?
                @errors << "Wallets are the same. Please choose another wallet" if @source_account == @recipient_account
            end
        end

        def validate_amount
            @errors << "Amount should be at least 0.01" if @amount.to_f == 0.00
        end
    end
end