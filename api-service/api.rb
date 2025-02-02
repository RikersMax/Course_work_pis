require 'sinatra'
require 'json'

require_relative './modules/alfa_api.rb'
require_relative './modules/sber_api.rb'
require_relative './modules/t-bank_api.rb'

set :default_content_type, :json

alfa = AlfaBank.new
sber = SberBank.new
t_bank = TBank.new

get "/" do
  if params.empty? then
    banks_version = [
      alfa.select_version,
      sber.select_version,
      t_bank.select_version
    ]
    return(banks_version.to_json)
  else
    BaseModule.select_version_from_params(params).to_json
  end 
end

get "/api/versions" do 
  #http://127.0.0.1:4567/api/all?something = name_bank

  if params.empty? then
    banks_version = [
      alfa.select_version,
      sber.select_version,
      t_bank.select_version
    ]
    return(banks_version.to_json)
  else
    BaseModule.select_version_from_params(params).to_json
  end 

end

get "/api/all_deposits" do
  result = {}

  bank_deposits = {    
    alfa.name_table => alfa.select_data,
    sber.name_table => sber.select_data,
    t_bank.name_table => t_bank.select_data
  }

  result[:bank_deposits] = bank_deposits
  result.to_json
end

get "/api/alfa" do 
  {alfa.name_table => alfa.select_data}.to_json
  #api_json_alfa.to_json
end


get "/api/sber" do 
  {sber.name_table => sber.select_data}.to_json
  #api_json_sber.to_json
end


get "/api/t-bank" do 
  {t_bank.name_table => t_bank.select_data}.to_json
  #api_json_t_bank.to_json
end
