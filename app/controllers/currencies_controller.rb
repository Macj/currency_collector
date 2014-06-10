class CurrenciesController < ApplicationController
  before_action :set_currency, only: [:show, :edit, :update, :destroy]
  # GET /currencies
  # GET /currencies.json
  def index
    @currencies = Currency.all
  end

  # GET /currencies/1
  # GET /currencies/1.json
  def show
    @countries = @currency.countries
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_currency
      @currency = Currency.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def currency_params
      params.require(:currency).permit(:name)
    end
end
