require 'savon'

module Webservicex
  def self.client
    client = Savon.client(wsdl: 'http://www.webservicex.net/country.asmx?WSDL')
  end

  def self.get_currencies
    response = client.call(:get_currencies)
    self.parse_currencies response.body
  end

  def self.get_countries
    response = client.call(:get_countries)
    self.parse_countries response.body
  end

  def self.get_country_by_currency_code code
    response = client.call(:get_country_by_currency_code, :message => { 'CurrencyCode' => code })
    self.parse_country_by_currency_code response.body
  end

  def self.get_currency_by_country country_name
    response = client.call(:get_currency_by_country, :message => { 'CountryName' => country_name })
    self.parse_currency_by_country response.body
  end

  private
  def self.parse_currencies body
    puts "Get currencies"
    resp_hash = Hash.from_xml(body[:get_currencies_response][:get_currencies_result])
    data = resp_hash["NewDataSet"]["Table"]
    data.each do |dat|
      #{"Name"=>"Zambia", "CountryCode"=>"zm", "Currency"=>"Kwacha", "CurrencyCode"=>"ZMK"}
      cur_data = {:name => dat["Currency"], :code => dat["CurrencyCode"]}
      currency = Currency.find_by_name(dat["Currency"]) || Currency.create(cur_data)
      country = Country.find_by_name(dat["Name"])
      country.update_attribute(:code, dat["CountryCode"])
      currency.countries << country
      VisitedCountry.create(:currency_id => currency.id, :country_id => country.id)
      #make some actions here
    end
  end

  def self.parse_countries body
    puts "Get countries"
    resp_hash = Hash.from_xml(body[:get_countries_response][:get_countries_result])
    data = resp_hash["NewDataSet"]["Table"]
    data.each do |dat|
      c = Country.find_by_name(dat["Name"]) || Country.create(:name => dat["Name"])
    end
  end

  def self.parse_country body
    resp_hash = Hash.from_xml(body[:get_country_response][:get_country_result])
    data = resp_hash["NewDataSet"]["Table"]
    data.each do |dat|
      #make some actions here
    end
  end

  def self.parse_country_by_currency_code body
    resp_hash = Hash.from_xml(body[:get_country_by_currency_code_response][:get_country_by_currency_code_result])
    data = resp_hash["NewDataSet"]["Table"].uniq
    data.each do |dat|
      #{"Name"=>"United States", "CountryCode"=>"us", "Currency"=>"Dollar", "CurrencyCode"=>"USD"}
      #make some actions here
    end
  end

  def self.parse_currency_by_country body
    resp_hash = Hash.from_xml(body[:get_currency_by_country_response][:get_currency_by_country_result])
    data = resp_hash["NewDataSet"]["Table"].uniq
    data.each do |dat|
      #{"Name"=>"Ukraine", "CountryCode"=>"ua", "Currency"=>"Hryvnia", "CurrencyCode"=>"UAG"}
      #make some actions here
    end
  end
end