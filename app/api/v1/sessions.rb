module V1
  class Sessions < Grape::API
    resource :sessions do

      desc 'Логин — возвращает JWT токен'
      params do
        requires :email, type: String
        requires :password, type: String
      end
      post :login do
        user = User.find_by(email: params[:email])

        if user&.valid_password?(params[:password])
          payload = { user_id: user.id }
          token = JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
          { token: token }
        else
          error!('Invalid email or password', 401)
        end
      end

    end
  end
end