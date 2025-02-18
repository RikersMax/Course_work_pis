module ProcessingResponses

  extend ActiveSupport::Concern

  included do 
      
    class ApiClient
      require 'net/http'
      require 'json'
      BASE_URL = 'http://127.0.0.1:4567' #dev
      #BASE_URL = 'http://172.20.0.10:4567' #docker compose

      def get_data(url)

        uri = URI("#{BASE_URL}#{url}")
        response = Net::HTTP.get_response(uri)

        case response
        when Net::HTTPSuccess
          JSON.parse(response.body)
        else
          { error: 'Ошибка при получении данных от API' }
        end

        rescue Errno::ECONNREFUSED, SocketError => e
          { error: 'Не удалось подключиться к API' }
      end
    end

    def defolt_requset(name_bank_id = '')      
      api_request = {      
        list_base_requiest: "/api/v1",
        find_deposite: "/api/v1/find/#{name_bank_id}",     
        api_versions: "/api/v1/versions",
        api_all_deposits: "/api/v1/all_deposits",
        api_alfa: "/api/v1/alfa",
        api_sber: "/api/v1/sber",
        api_tbank: "/api/v1/t-bank"    
        }
    end

  end

end