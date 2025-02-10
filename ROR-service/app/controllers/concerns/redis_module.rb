module RedisModule
  extend ActiveSupport::Concern


  included do 
    def r_connect
      Redis.new(db: 0)
    end


=begin    
    def r_get_parse(str)
      result_r = r_connect.get(str)
      return false unless result_r.present?
      
      JSON.parse(result_r).symbolize_keys
    end
=end
    def r_delete_remember_token_user
      r_connect.del(current_user.remember_token_digest)
    end
  end

end