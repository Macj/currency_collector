class CountriesCurrencies < ActiveRecord::Base
  self.table_name = :countries_currencies
  belongs_to :currency
  belongs_to :country
end
