class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :country_ids
      t.string :description
      t.date :t_date

      t.timestamps
    end
  end
end
