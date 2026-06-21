module Entities
  class Book < Grape::Entity
    expose :id
    expose :title
    expose :text

    expose :genre, using: Entities::Genre::Nested
    expose :authors, using: Entities::Authors

    expose :average_rating do |book|
      ratings = book.ratings
      ratings.any? ? (ratings.sum(:value).to_f / ratings.count).round(2) : ' Оценок еще нет '
    end
  end
end