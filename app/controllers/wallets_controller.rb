class WalletsController < ApplicationController
    before_action :find_wallet

    def show
       @transactions = AccountTransaction.where(origin: @account).or(AccountTransaction.where(recipient: @account))
    end
    
    def new_deposit
    end

    def deposit
        @bank_account = Account.find_or_create_by(account_type: :bank_account, 
                                                  owner: @account, 
                                                  currency: Account::ACCOUNT_CURRENCY)

        errors = WalletTransaction::ValidateTransaction.new(
                amount: params[:amount],
                type: :deposit,
                source_account: @bank_account,
                recipient_account: @account
        ).perform

        if errors.size > 0
            alert = { class: 'danger', message: errors }
            flash.now[:alert] = alert
            render 'new_deposit'
        else
            wallet = WalletTransaction::TransactionActivity.new(
                   amount: params[:amount],
                   type: :deposit,
                   source_account: @bank_account,
                   recipient_account: @account
            ).perform

            redirect_to @account.account_holder
        end
    end
    
    def new_withdraw
    end

    def withdraw
        errors = WalletTransaction::ValidateTransaction.new(
            amount: params[:amount],
            type: :withdraw,
            source_account: @account
        ).perform

        if errors.size > 0
            alert = { class: 'danger', message: errors }
            flash.now[:alert] = alert
            render 'new_withdraw'
        else
            wallet = WalletTransaction::TransactionActivity.new(
                   amount: params[:amount],
                   type: :withdraw,
                   source_account: @account
            ).perform

            redirect_to @account.account_holder
        end
    end
    
    def new_transfer
    end

    def transfer
        @recipient = Account.wallet.find_by(account_number: account_params[:account_number])

        errors = WalletTransaction::ValidateTransaction.new(
            amount: params[:amount],
            type: :transfer,
            source_account: @account,
            recipient_account: @recipient
        ).perform

        if errors.size > 0
            alert = { class: 'danger', message: errors }
            flash.now[:alert] = alert
            render 'new_transfer'
        else
            wallet = WalletTransaction::TransactionActivity.new(
                   amount: params[:amount],
                   type: :transfer,
                   source_account: @account,
                   recipient_account: @recipient
            ).perform

            redirect_to @account.account_holder
        end
    end

    private

    def find_wallet
      @account = Account.wallet.find_by(id: params[:id])
    end

    def account_params
      params.require(:account).permit(:amount, :transaction_type, :account_number)
    end
end