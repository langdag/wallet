# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

(1..10).each do |id|
    User.create!(
        id: id, 
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email, 
    )
end

(1..10).each do |id|
    Team.create!(
        id: id, 
        name: Faker::Team.name,
        tagline: Faker::Lorem.sentence(word_count: 2) ,
        team_size: %w[small medium large].sample, 
    )
end

(1..10).each do |id|
    Stock.create!(
        id: id, 
        name: Faker::Company.name,
        code: Faker::Finance.ticker,
        company: Faker::Company.industry, 
    )
end