class HbtmForCurrencyAndCountry < ActiveRecord::Migration
  def change
    create_table :countries_currencies, id: false do |t|
      t.belongs_to :country
      t.belongs_to :currency
    end
  end
end
