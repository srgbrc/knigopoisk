require "test_helper"

class BookshelfBook::Operation::DeleteTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "shelfbook_delete@test.com", password: "password123", role: 0)
    @genre = Genre.create!(name: "Жанр удаления полки книги")
    @book = Book.create!(title: "Книга удаления из полки", creator: @user, genre: @genre)
    @bookshelf = Bookshelf.create!(name: "Полка с книгами", user: @user)
    @bookshelf_book = BookshelfBook.create!(bookshelf: @bookshelf, book: @book)
  end

  test "удаляет книгу из полки" do
    result = BookshelfBook::Operation::Delete.call(
      params: { id: @bookshelf_book.id },
      current_user: @user
    )

    assert result.success?
    assert_nil BookshelfBook.find_by(id: @bookshelf_book.id)
  end

  test "провал если запись не найдена" do
    result = BookshelfBook::Operation::Delete.call(
      params: { id: 0 },
      current_user: @user
    )

    assert result.failure?
    assert_equal ["bookshelf book not found"], result[:error]
  end

  test "нельзя удалить из чужой полки" do
    other_user = User.create!(email: "other_shelfbook_del@test.com", password: "password123", role: 0)

    result = BookshelfBook::Operation::Delete.call(
      params: { id: @bookshelf_book.id },
      current_user: other_user
    )

    assert result.failure?
    assert_equal ["bookshelf book not found"], result[:error]
  end
end
