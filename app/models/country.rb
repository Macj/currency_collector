class Country < ActiveRecord::Base
  has_and_belongs_to_many :currencies

  def visited_for currency
    elem = VisitedCountry.find_by_currency_id_and_country_id(currency.id, self.id)
    elem.visited
  end

  def visit
    cur_list = VisitedCountry.where(:country_id => self.id)
    cur_list.each do |cur|
      cur.update_attribute(:visited, true)
    end
  end
end
