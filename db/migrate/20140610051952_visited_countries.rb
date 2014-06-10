class VisitedCountries < ActiveRecord::Migration
  def change
    create_table :visited_countries do |t|
      t.integer :country_id
      t.integer :currency_id
      t.boolean :visited, :default => false
      t.timestamp
    end
  end
end
