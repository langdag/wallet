class WalletsController < ApplicationController
    before_action :find_wallet

    def show
       @transactions = AccountTransaction.where(origin: @account).or(AccountTransaction.where(recipient: @account))
    end
    
    def new_deposit
    end

    def deposit
        @bank_account = Account.find_or_create_by(account_type: :bank_account, owner: @account, currency: Account::ACCOUNT_CURRENCY)

        errors = WalletTransaction::ValidateTransaction.new(account_params[:amount], "deposit", @bank_account, @account).perform

        if errors.size > 0
            flash[:danger] = errors
            render 'new_deposit'
        else
            wallet = WalletTransaction::TransactionActivity.new(account_params[:amount], "deposit", @bank_account, @account).perform

            flash[:success] = "The transaction have been made successfully"

            redirect_to wallet_new_deposit_path(@account.owner.wallet_account)
        end
    end
    
    def new_withdraw
    end

    def withdraw
        errors = WalletTransaction::ValidateTransaction.new(account_params[:amount], "withdraw", @account).perform

        if errors.size > 0
            flash[:danger] = errors
            render 'new_withdraw'
        else
            wallet = WalletTransaction::TransactionActivity.new(account_params[:amount], "withdraw", @account).perform

            flash[:success] = "The transaction have been made successfully"

            redirect_to wallet_new_withdraw_path(@account.owner.wallet_account)
        end
    end
    
    def new_transfer
    end

    def transfer
        @recipient = Account.wallet.find_by(account_number: account_params[:account_number])

        errors = WalletTransaction::ValidateTransaction.new(account_params[:amount], "transfer", @account, @recipient).perform

        if errors.size > 0
            flash[:danger] = errors
            render 'new_transfer'
        else
            wallet = WalletTransaction::TransactionActivity.new(account_params[:amount], "transfer", @account, @recipient).perform

            flash[:success] = "The transaction have been made successfully"

            redirect_to wallet_new_transfer_path(@account.owner.wallet_account)
        end
    end

    private

    def find_wallet
      @account = Account.wallet.find_by(id: params[:id]) || Account.wallet.find_by(id: params[:wallet_id])
    end

    def account_params
      params.require(:account).permit(:amount, :transaction_type, :account_number)
    end
end