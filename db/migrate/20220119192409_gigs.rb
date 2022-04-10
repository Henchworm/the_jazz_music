class Gigs < ActiveRecord::Migration[6.0]
  def change
    create_table :gigs do |t|
      t.datetime :date
      t.string :venue
      t.string :band_name
      t.text :deets
      t.string :music_link
      t.timestamps
    end
  end
end
