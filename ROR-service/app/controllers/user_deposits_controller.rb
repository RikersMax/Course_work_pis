class UserDepositsController < ApplicationController

 
  def index
    api_url = defolt_recuset[:root]
    data = ApiClient.new.get_data(api_url)
    @all_deposits = data
  end

  def show
    url_params = params[:id]
    api_url = defolt_recuset[url_params.to_sym]
    data = ApiClient.new.get_data(api_url)
    @all_deposits = data

  end

  def defolt_recuset
    api_request = {
      root: '/',
      api_version: "/api/versions",
      api_all_deposits: "/api/all_deposits",
      api_alfa: "/api/alfa",
      api_sber: "/api/sber",
      api_tbank: "/api/t-bank"    
    }
  end
 
end
