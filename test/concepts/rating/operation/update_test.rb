require "test_helper"

class Rating::Operation::UpdateTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "rating_update@test.com", password: "password123", role: 0)
    @genre = Genre.create!(name: "Жанр рейтинг апдейт")
    @book = Book.create!(title: "Книга рейтинг апдейт", creator: @user, genre: @genre)
    @rating = Rating.create!(value: 5, user: @user, book: @book)
  end

  test "обновляет рейтинг" do
    result = Rating::Operation::Update.call(
      params: { book_id: @book.id, value: 8 },
      current_user: @user
    )

    assert result.success?
    assert_equal 8, @rating.reload.value
  end

  test "провал если рейтинг не найден" do
    other_user = User.create!(email: "other_rating@test.com", password: "password123", role: 0)

    result = Rating::Operation::Update.call(
      params: { book_id: @book.id, value: 8 },
      current_user: other_user
    )

    assert result.failure?
    assert_equal ["rating not found"], result[:error]
  end

  test "провал при невалидном значении" do
    result = Rating::Operation::Update.call(
      params: { book_id: @book.id, value: 15 },
      current_user: @user
    )

    assert result.failure?
    assert_not_nil result[:error]
  end
end
