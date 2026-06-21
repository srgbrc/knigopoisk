require "test_helper"

class Book::Operation::DeleteTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "book_delete@test.com", password: "password123", role: 0)
    @genre = Genre.create!(name: "Жанр удаление")
    @book = Book.create!(title: "Книга для удаления", creator: @user, genre: @genre)
  end

  test "удаляет книгу" do
    result = Book::Operation::Delete.call(params: { book_id: @book.id })

    assert result.success?
    assert_nil Book.find_by(id: @book.id)
  end

  test "провал если книга не найдена" do
    result = Book::Operation::Delete.call(params: { book_id: 0 })

    assert result.failure?
    assert_equal ["book not found"], result[:error]
  end
end
