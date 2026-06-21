require "test_helper"

class Rating::Operation::CreateTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "rating_create@test.com", password: "password123", role: 0)
    @genre = Genre.create!(name: "Жанр рейтинг")
    @book = Book.create!(title: "Книга для рейтинга", creator: @user, genre: @genre)
  end

  test "создаёт рейтинг" do
    result = Rating::Operation::Create.call(
      params: { rating: 9, book_id: @book.id },
      current_user: @user
    )

    assert result.success?
    assert result[:rating].persisted?
    assert_equal 9, result[:rating].value
  end

  test "провал при значении ниже 1" do
    result = Rating::Operation::Create.call(
      params: { rating: 0, book_id: @book.id },
      current_user: @user
    )

    assert result.failure?
    assert_not_nil result[:error]
  end

  test "провал при значении выше 10" do
    result = Rating::Operation::Create.call(
      params: { rating: 11, book_id: @book.id },
      current_user: @user
    )

    assert result.failure?
    assert_not_nil result[:error]
  end

  test "провал при nil значении" do
    result = Rating::Operation::Create.call(
      params: { rating: nil, book_id: @book.id },
      current_user: @user
    )

    assert result.failure?
    assert_not_nil result[:error]
  end

  test "граничное значение 1 допустимо" do
    result = Rating::Operation::Create.call(
      params: { rating: 1, book_id: @book.id },
      current_user: @user
    )

    assert result.success?
  end

  test "граничное значение 10 допустимо" do
    result = Rating::Operation::Create.call(
      params: { rating: 10, book_id: @book.id },
      current_user: @user
    )

    assert result.success?
  end
end
