module V1
  class Ratings < Grape::API
    resource :ratings do

      get do
        ratings = Rating.all
        present ratings, with: Entities::Rating
      end

      post do
        result = Rating::Operation::Create.call(params: params, current_user:curent_user)
        if result.success?
          present result[:rating], with: Entities::Rating
        else
          error!(result[:error], 422)
        end
      end

      put do
        result = Rating::Operation::Update.call(params: params, current_user: current_user)
        if result.success?
          present result[:rating], with: Entities::Rating
        else
          error!(result[:error], 422)
        end
      end

      delete do
        result = Rating::Operation::Delete.call(params: params, current_user: current_user)
        if result.success?
          status 204
        else
          error!(result[:error], 422)
        end
      end
    end
  end
end
