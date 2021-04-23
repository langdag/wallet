class Stock < ApplicationRecord
    validates :name, :code, :company, presence: true
end
