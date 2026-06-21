module V1
  class Genres < Grape::API
    resource :genres do

      get do
        genres = Genre.all
        present genres, with: Entities::Genre
      end

      get ':id' do
        genre = Genre.find(params[:id])
        present genre, with: Entities::Genre
      end

      put ':id' do
        result = Genre::Operation::Update.call(params: params)
        if result.success?
          present result[:genre], with: Entities::Genre
        else
          error!(result[:error], 422)
        end
      end

      post do
        result = Genre::Operation::Create.call(params: params)
        if result.success?
          present result[:genre], with: Entities::Genre
        else
          error!(result[:error], 422)
        end
      end

      delete ':id' do
        result = Genre::Operation::Delete.call(params: params)
        if result.success?
          status 204
        else
          error!(result[:error], 422)
        end
      end
    end
  end
end