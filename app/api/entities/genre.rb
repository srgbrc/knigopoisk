module Entities
  class Genre < Grape::Entity
    class Nested < Grape::Entity
      expose :id
      expose :name
    end

    expose :id
    expose :name
    expose :books do |genre|
      genre.books.map { |book| { id: book.id, title: book.title, authors: book.authors } }
    end
  end
end
