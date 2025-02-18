#bundle exec rackup --host 127.0.0.1 -p 4567
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
  redirect("/api/v1")
end

get "/api/v1" do
   list_base_requiest = {
    requiests: {
      check_version_tables: '/api/v1/versions',
      show_all_deposete: '/api/v1/all_deposits',
      show_alfa_bank_deposete: '/api/v1/alfa',
      show_sber_bank_deposete: '/api/v1/sber',
      show_t_bank_deposete: '/api/v1/t-bank',
      find_by_bank_and_id_deposite: '/api/v1/find/[Name_bank:id]'
    }
   }

  return(list_base_requiest.to_json)
end

get "/api/v1/versions" do 
  #http://127.0.0.1:4567/api/all?something = name_bank


  if params.empty? then

    versions = {}
    versions[:versions] = alfa.select_version.merge(sber.select_version, t_bank.select_version)

    return(versions.to_json)
  else
    BaseModule.select_version_from_params(params).to_json
  end 

end

get "/api/v1/all_deposits" do
  result = {}

  bank_deposits = {    
    alfa.name_table => alfa.select_data,
    sber.name_table => sber.select_data,
    t_bank.name_table => t_bank.select_data
  }

  result[:bank_deposits] = bank_deposits
  return(result.to_json)
end

get "/api/v1/alfa" do 
  {alfa.name_table => alfa.select_data}.to_json
  #api_json_alfa.to_json
end


get "/api/v1/sber" do 
  {sber.name_table => sber.select_data}.to_json
  #api_json_sber.to_json
end


get "/api/v1/t-bank" do 
  {t_bank.name_table => t_bank.select_data}.to_json
  #api_json_t_bank.to_json
end

get "/api/v1/find/:id" do
  #Alfa_bank:1
  test_params = params[:id].split(':')
  result = BaseModule.find_by_bank_and_id(test_params[0], test_params[1])
  {deposit: result}.to_json
end