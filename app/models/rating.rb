class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :book
  validates :value, presence: true, inclusion: { in: 1..10 }
end
