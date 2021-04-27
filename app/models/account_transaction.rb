class AccountTransaction < ApplicationRecord
    belongs_to :origin, class_name: "Account", foreign_key: "origin_account_id"
    belongs_to :recipient, class_name: "Account", foreign_key: "recipient_account_id", optional: true

    enum transaction_type: [:withdraw, :deposit, :transfer]

    validates :amount, presence: true, numericality: true
    validates :transaction_type, presence: true, inclusion: { in: transaction_types.keys }
end
