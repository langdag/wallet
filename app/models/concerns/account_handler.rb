module AccountHandler
    extend ActiveSupport::Concern
  
    included do
      has_many :accounts, as: :owner
      after_commit :create_wallet
    end

    def wallet_account
      accounts.find_by(account_type: Account::account_types[:wallet])
    end

    def create_wallet
      Account.create!(
        account_type: Account::account_types[:wallet],
        currency:   Account::ACCOUNT_CURRENCY,
        owner_type: self.class.name,
        owner_id:   self.id
      )
    end
end