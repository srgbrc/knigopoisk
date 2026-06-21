require "test_helper"

class Rating::Operation::DeleteTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "rating_delete@test.com", password: "password123", role: 0)
    @genre = Genre.create!(name: "Жанр рейтинг удаление")
    @book = Book.create!(title: "Книга рейтинг удаление", creator: @user, genre: @genre)
    @rating = Rating.create!(value: 6, user: @user, book: @book)
  end

  test "удаляет рейтинг" do
    result = Rating::Operation::Delete.call(
      params: { book_id: @book.id },
      current_user: @user
    )

    assert result.success?
    assert_nil Rating.find_by(id: @rating.id)
  end

  test "провал если рейтинг не найден" do
    other_user = User.create!(email: "no_rating@test.com", password: "password123", role: 0)

    result = Rating::Operation::Delete.call(
      params: { book_id: @book.id },
      current_user: other_user
    )

    assert result.failure?
    assert_equal ["rating not found"], result[:error]
  end
end
