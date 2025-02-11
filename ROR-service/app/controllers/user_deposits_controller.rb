class UserDepositsController < ApplicationController

 
  def index
    api_url = defolt_requset[:api_versions]
    data = ApiClient.new.get_data(api_url)
    @all_deposits = data
  end

  def show
    url_params = params[:id]
    api_url = defolt_requset[url_params.to_sym]
    data = ApiClient.new.get_data(api_url)
    @all_deposits = data

  end

  def defolt_requset
    api_request = {      
      list_base_requiest: '/api/v1',
      api_versions: "/api/v1/versions",
      api_all_deposits: "/api/v1/all_deposits",
      api_alfa: "/api/v1/alfa",
      api_sber: "/api/v1/sber",
      api_tbank: "/api/v1/t-bank"    
    }
  end
 
end
