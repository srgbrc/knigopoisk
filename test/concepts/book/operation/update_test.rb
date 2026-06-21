require "test_helper"

class Book::Operation::UpdateTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "book_update@test.com", password: "password123", role: 0)
    @genre = Genre.create!(name: "Фантастика тест")
    @book = Book.create!(title: "Старое название", creator: @user, genre: @genre)
    @author = Author.create!(name: "Булгаков")
  end

  test "обновляет название книги" do
    result = Book::Operation::Update.call(
      params: {
        book_id: @book.id,
        book: { title: "Мастер и Маргарита" },
        author_names: ["Булгаков"]
      }
    )

    assert result.success?
    assert_equal "Мастер и Маргарита", @book.reload.title
  end

  test "обновляет авторов книги" do
    author2 = Author.create!(name: "Пастернак")
    @book.book_authors.create!(author: @author)

    result = Book::Operation::Update.call(
      params: {
        book_id: @book.id,
        book: { title: @book.title },
        author_names: ["Пастернак"]
      }
    )

    assert result.success?
    assert_equal ["Пастернак"], @book.reload.authors.pluck(:name)
  end

  test "провал если книга не найдена" do
    result = Book::Operation::Update.call(
      params: { book_id: 0, book: { title: "Новое" }, author_names: [] }
    )

    assert result.failure?
    assert_equal ["book not found"], result[:error]
  end

  test "провал при невалидном названии" do
    result = Book::Operation::Update.call(
      params: {
        book_id: @book.id,
        book: { title: "Ок" },
        author_names: ["Булгаков"]
      }
    )

    assert result.failure?
    assert_not_nil result[:error]
  end

  test "провал если автор не существует в БД" do
    result = Book::Operation::Update.call(
      params: {
        book_id: @book.id,
        book: { title: "Нормальное название" },
        author_names: ["Несуществующий"]
      }
    )

    assert result.failure?
    assert_match "Сначала добавтье авторов", result[:error]
  end
end
