class VisitedCountriesController < ApplicationController
  before_action :set_country, only: [:visit, :unvisit]
  before_action :authenticate_user!
  # make collected currency in one country, and country visited with this currency
  def visit
    puts params
    elem = VisitedCountry.find_by_country_id_and_currency_id(@country.id, @currency.id)
    elem.visited = true
    elem.save
    redirect_to currency_path(@currency)
  end

  # make uncollected currency in one country, and country unvisited with this currency
  def unvisit
    elem = VisitedCountry.find_by_country_id_and_currency_id(@country.id, @currency.id)
    elem.visited = false
    elem.save
    redirect_to currency_path(@currency)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_country
      @country = Country.find(params[:country_id])
      @currency = Country.find(params[:currency_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def visited_country_params
      params.require(:visited_country).permit(:country_id, :currency_id)
    end
end
