class ApplicationController < ActionController::Base
  include UserAuthenticate
  include ProcessingResponses
  include RedisModule
end
