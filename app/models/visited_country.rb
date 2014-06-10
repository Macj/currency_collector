class VisitedCountry < ActiveRecord::Base
  belongs_to :currencies
  belongs_to :country

  def self.visited_countries_count
    self.select(:country_id).where(:visited => true).map(&:country_id).uniq.count
  end
end
