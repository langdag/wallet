class Stock < ApplicationRecord
    include AccountHandler

    validates :name, :code, :company, presence: true
end
