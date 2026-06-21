class Api < Grape::API
  prefix :api
  version 'v1', using: :path
  format :json

  helpers do
    def current_user
      token = headers['Authorization']&.split(' ')&.last
      return error!('Unauthorized', 401) unless token

      payload = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')[0]
      User.find(payload['user_id'])
    rescue JWT::DecodeError
      error!('Unauthorized', 401)
    end
  end

  mount V1::Base
end