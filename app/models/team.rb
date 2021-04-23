class Team < ApplicationRecord
    validates :name, presence: true
    validates :tagline, length: {minimum: 5, maximum: 30}, allow_blank: true

    enum team_size: [:small, :medium, :large]
end
