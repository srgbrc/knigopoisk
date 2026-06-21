require "test_helper"

class BookshelfBook::Operation::CreateTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "shelfbook_create@test.com", password: "password123", role: 0)
    @genre = Genre.create!(name: "Жанр полки книги")
    @book = Book.create!(title: "Книга в полку", creator: @user, genre: @genre)
    @bookshelf = Bookshelf.create!(name: "Моя полка", user: @user)
  end

  test "добавляет книгу в полку" do
    result = BookshelfBook::Operation::Create.call(
      params: { bookshelf_id: @bookshelf.id, book_id: @book.id },
      current_user: @user
    )

    assert result.success?
    assert result[:bookshelf_book].persisted?
    assert_equal 1, @bookshelf.books.count
  end

  test "провал если полка не найдена" do
    result = BookshelfBook::Operation::Create.call(
      params: { bookshelf_id: 0, book_id: @book.id },
      current_user: @user
    )

    assert result.failure?
    assert_equal ["bookshelf not found"], result[:error]
  end

  test "провал если книга не найдена" do
    result = BookshelfBook::Operation::Create.call(
      params: { bookshelf_id: @bookshelf.id, book_id: 0 },
      current_user: @user
    )

    assert result.failure?
    assert_equal ["book not found"], result[:error]
  end

  test "провал при дублировании книги в полке" do
    BookshelfBook.create!(bookshelf: @bookshelf, book: @book)

    result = BookshelfBook::Operation::Create.call(
      params: { bookshelf_id: @bookshelf.id, book_id: @book.id },
      current_user: @user
    )

    assert result.failure?
    assert_equal ["book already in bookshelf"], result[:error]
  end

  test "нельзя добавить книгу в чужую полку" do
    other_user = User.create!(email: "other_shelfbook@test.com", password: "password123", role: 0)

    result = BookshelfBook::Operation::Create.call(
      params: { bookshelf_id: @bookshelf.id, book_id: @book.id },
      current_user: other_user
    )

    assert result.failure?
    assert_equal ["bookshelf not found"], result[:error]
  end
end
