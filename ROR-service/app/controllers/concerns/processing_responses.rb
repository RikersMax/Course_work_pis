module ProcessingResponses

  extend ActiveSupport::Concern

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


  included do 
    ApiClient
  end
end