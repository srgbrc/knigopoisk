module V1
  class Books < Grape::API
    resource :books do

      get do
        books = Book.all
        present books, with: Entities::Book
      end

      get ':id' do
        book = Book.find_by(id: params[:id])
        present book, with: Entities::Book
      end

      put ':book_id' do
        result = Book::Operation::Update.call(params: params)
        if result.success?
          present result[:book], with: Entities::Book
        else
          error!(result[:error], 422)
        end
      end

      post do
        result = Book::Operation::Create.call(params: params, current_user: 1)
        if result.success?
          present result[:book], with: Entities::Book
        else
          error!(result[:error], 422)
        end
      end

      delete ':book_id' do
        result = Book::Operation::Delete.call(params: params)
        if result.success?
          status 204
        else
          error!(result[:error], 422)
        end
      end
    end
  end
end