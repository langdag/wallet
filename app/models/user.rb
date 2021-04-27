class User < ApplicationRecord
    include AccountHandler

    validates :first_name, :last_name, :email, presence: true
    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
end
