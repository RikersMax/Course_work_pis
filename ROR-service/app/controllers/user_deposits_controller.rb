class UserDepositsController < ApplicationController

  def index
    api_url = defolt_requset[:api_all_deposits]
    data = ApiClient.new.get_data(api_url)

    if data.key?(:error) then
      @all_deposits = data
      @result = false
    else
      @all_deposits = data['bank_deposits']
      @result = true
    end

    #render(json: @all_deposits)
  end

  def show
    name_bank_id = params[:id]
    api_url = defolt_requset(name_bank_id)[:find_deposite]
    data = ApiClient.new.get_data(api_url)

    @deposit = data['deposit']    
  end

  

end
