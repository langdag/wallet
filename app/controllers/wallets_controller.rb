class WalletsController < ApplicationController
    before_action :find_wallet, only: [:deposit, :withdraw, :transfer]
    
    def new_deposit
    end

    def deposit
        @bank_account = Account.find_or_create_by(account_type: :bank_account, 
                                                  owner: @account, 
                                                  currency: Account::ACCOUNT_CURRENCY)

        errors = WalletTransaction::ValidateTransaction.new(
                amount: params[:amount]
                type: params[:transaction_type]
                source_account: @bank_account
                recipient_account: @account
        ).perform

        if errors.size > 0
            alert = { class: 'danger', message: errors }
            flash.now[:alert] = alert
            render 'new_deposit'
        else
            wallet = WalletTransaction::TransactionActivity.new(
                   amount: params[:amount]
                   type: params[:transaction_type]
                   source_account: @bank_account
                   recipient_account: @account
            ).perform

            redirect_to @account.account_holder
        end
    end
    
    def new_withdraw
    end

    def withdraw
        errors = WalletTransaction::ValidateTransaction.new(
            amount: params[:amount]
            type: params[:transaction_type]
            source_account: @account
        ).perform

        if errors.size > 0
            alert = { class: 'danger', message: errors }
            flash.now[:alert] = alert
            render 'new_deposit'
        else
            wallet = WalletTransaction::TransactionActivity.new(
                   amount: params[:amount]
                   type: params[:transaction_type]
                   source_account: @account
            ).perform

            redirect_to @account.account_holder
        end
    end
    
    def new_transfer
    end

    def transfer
    end

    private

    def find_wallet
      @account = Account.wallet.find_by(id: params[:id])
    end

    def account_params
      params.require(:account).permit(:amount, :transaction_type, :recipient_id)
    end
end