# app/api/entities/rating.rb
module Entities
  class Rating < Grape::Entity
    expose :id
    expose :value
    expose :book_id
    expose :user_id
  end
end