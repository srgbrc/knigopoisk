class Book < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :genre
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  has_many :ratings

  validates :title, presence: true, length: {minimum: 5, maximum: 50}
end
