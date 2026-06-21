require "test_helper"

class Genre::Operation::DeleteTest < ActiveSupport::TestCase
  setup do
    @genre = Genre.create!(name: "Приключения")
  end

  test "удаляет жанр" do
    result = Genre::Operation::Delete.call(params: { id: @genre.id })

    assert result.success?
    assert_nil Genre.find_by(id: @genre.id)
  end

  test "обнуляет genre_id у связанных книг при удалении" do
    user = User.create!(email: "g@test.com", password: "password123", role: 0)
    book = Book.create!(title: "Тестовая книга", creator: user, genre: @genre)

    result = Genre::Operation::Delete.call(params: { id: @genre.id })

    assert result.success?
    assert_nil book.reload.genre_id
  end

  test "провал если жанр не найден" do
    result = Genre::Operation::Delete.call(params: { id: 0 })

    assert result.failure?
    assert_equal ["genre not found"], result[:error]
  end
end
