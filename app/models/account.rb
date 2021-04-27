class Account < ApplicationRecord
    has_many :transactions, class_name: "AccountTransaction", foreign_key: "recipient_account_id"
    has_many :transfered_transactions, class_name: "AccountTransaction", foreign_key: "origin_account_id"
    belongs_to :owner, polymorphic: true

    validates :currency, :account_type, :balance, presence: true

    after_commit :generate_account_number, on: :create

    enum account_type: [:wallet, :bank_account]

    ACCOUNT_CURRENCY = "USD".freeze

    def generate_account_number
        begin
            self.account_number = SecureRandom.random_number(1000000000).to_s
            self.save
        rescue ActiveRecord::RecordNotUnique
            retry
        end
    end
end
