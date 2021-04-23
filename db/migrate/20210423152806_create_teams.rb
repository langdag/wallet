class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :tagline
      t.integer :team_size

      t.timestamps
    end
  end
end
