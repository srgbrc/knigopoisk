module Entities
  class Authors < Grape::Entity
    expose :id
    expose :name
  end
end