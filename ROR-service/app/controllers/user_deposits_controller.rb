class UserDepositsController < ApplicationController

  before_action(:require_authentication, only: 'create')

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

  def new
    name_bank_id = params[:id]
    api_url = defolt_requset(name_bank_id)[:find_deposite]
    data = ApiClient.new.get_data(api_url)

    @deposit = data['deposit'] 
  end

  def show
    #redner(plain: params)
    # name_bank_id = params[:id]
    # api_url = defolt_requset(name_bank_id)[:find_deposite]
    # data = ApiClient.new.get_data(api_url)

    # @deposit = data['deposit']
  end

  def create    
    params_user_deposit = params_for_create

    user_id = current_user.id
    time_start = Time.now
    time_end = time_start.next_month(params_user_deposit[:month].to_i)
    term_in_days = (time_end.to_i - time_start.to_i) / 86400

    params_user_deposit.delete(:month)

    params_user_deposit.merge!(
      user_id: user_id,
      term_in_days: term_in_days,
      deposit_start: time_start,
      deposit_end: time_end
      )

    user_deposit = UserDeposit.new(params_user_deposit.to_h)

    if user_deposit.save then
      flash[:message] = t('flash.message.successfully')
      redirect_to('/')
    else
      flash[:message] = t('flash.message.error')
      redirect_to('/')
    end
    #debugger
  end

  private

  def params_for_create
    params.require(:form_deposit).permit(:deposit_title, :rate, :amount_money, :month, :deposit, :withdrawal)
  end

end
