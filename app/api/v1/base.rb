module V1
  class Base < Grape::API
    mount V1::Books
    mount V1::Authors
    mount V1::Genres
    mount V1::Ratings
    mount V1::Sessions
  end
end