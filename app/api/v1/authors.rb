module V1
  class Authors < Grape::API
    resource :authors do

      get do
        authors = Author.all
        present authors, with: Entities::Author
      end

      get ':id' do
        author = Author.find(params[:id])
        present author, with: Entities::Author
      end

      put ':id' do
        result = Author::Operation::Update.call(params: params)
        if result.success?
          present result[:author], with: Entities::Author
        else
          error!(result[:error], 422)
        end
      end

      post do
        result = Author::Operation::Create.call(params: params)
        if result.success?
          present result[:author], with: Entities::Author
        else
          error!(result[:error],422)
        end
      end

      delete ':id' do
        result = Author::Operation::Delete.call(params: params)
        if result.success?
          status 204
        else
          error!(result[:error],422)
        end
      end
    end
  end
end