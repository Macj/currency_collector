class Currency < ActiveRecord::Base
  has_and_belongs_to_many :countries

  def unvisited_countries_count
    VisitedCountry.where(:currency_id => self.id, :visited => false).count
  end
end
