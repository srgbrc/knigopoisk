require "test_helper"

class Author::Operation::UpdateTest < ActiveSupport::TestCase
  setup do
    @author = Author.create!(name: "Гоголь")
  end

  test "обновляет имя автора" do
    result = Author::Operation::Update.call(
      params: { id: @author.id, author: { name: "Тургенев" } }
    )

    assert result.success?
    assert_equal "Тургенев", @author.reload.name
  end

  test "провал если автор не найден" do
    result = Author::Operation::Update.call(
      params: { id: 0, author: { name: "Тургенев" } }
    )

    assert result.failure?
    assert_equal ["author not found"], result[:error]
  end

  test "провал при невалидном имени" do
    result = Author::Operation::Update.call(
      params: { id: @author.id, author: { name: "Invalid Name" } }
    )

    assert result.failure?
    assert_not_nil result[:error]
  end
end
