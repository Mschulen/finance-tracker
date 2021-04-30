class StocksController < ApplicationController

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
    publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
    secret_token: Rails.application.credentials.iex_client[:secret_api_key],
    endpoint: "https://sandbox.iexapis.com/v1",)

    @stock = Stock.new

    @stock.ticker = ticker_symbol
    
    @stock.last_price = client.quote(ticker_symbol).latest_price
 
    @stock.name = client.company(ticker_symbol).company_name

    @stock.logo = client.logo(ticker_symbol).url
 
    @stock
  end

  def search
    @stock_display = StocksController.new_lookup(params[:stock])
    
    render 'users/my_portfolio'
  end
end