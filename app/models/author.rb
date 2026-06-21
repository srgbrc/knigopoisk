class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors

  validates :name, presence: true, uniqueness: true, format: { with: /\A[а-яёА-ЯЁ\s\-]+\z/, message: "только русские буквы" }
end
