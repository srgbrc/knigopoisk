require "test_helper"

class Book::Operation::CreateTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "book_create@test.com", password: "password123", role: 0)
    @genre = Genre.create!(name: "Классика")
  end

  test "создаёт книгу без авторов" do
    result = Book::Operation::Create.call(
      params: { book: { title: "Мёртвые души", genre_id: @genre.id } },
      current_user: @user.id
    )

    assert result.success?
    assert result[:book].persisted?
    assert_equal "Мёртвые души", result[:book].title
    assert_equal @user.id, result[:book].creator_id
  end

  test "создаёт книгу с авторами" do
    author = Author.create!(name: "Набоков")

    result = Book::Operation::Create.call(
      params: {
        book: { title: "Лолита книга", genre_id: @genre.id },
        author_names: ["Набоков"]
      },
      current_user: @user.id
    )

    assert result.success?
    assert_equal 1, result[:book].authors.count
  end

  test "провал при слишком коротком названии" do
    result = Book::Operation::Create.call(
      params: { book: { title: "Кот", genre_id: @genre.id } },
      current_user: @user.id
    )

    assert result.failure?
  end

  test "провал при названии длиннее 50 символов" do
    long_title = "А" * 51
    result = Book::Operation::Create.call(
      params: { book: { title: long_title, genre_id: @genre.id } },
      current_user: @user.id
    )

    assert result.failure?
  end

  test "провал при пустом названии" do
    result = Book::Operation::Create.call(
      params: { book: { title: "", genre_id: @genre.id } },
      current_user: @user.id
    )

    assert result.failure?
  end

  test "неизвестный автор в author_names не создаёт BookAuthor" do
    result = Book::Operation::Create.call(
      params: {
        book: { title: "Книга о чём-то", genre_id: @genre.id },
        author_names: ["Несуществующий Автор"]
      },
      current_user: @user.id
    )

    assert result.success?
    assert_equal 0, result[:book].authors.count
  end
end
