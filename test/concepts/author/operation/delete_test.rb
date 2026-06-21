require "test_helper"

class Author::Operation::DeleteTest < ActiveSupport::TestCase
  setup do
    @author = Author.create!(name: "Лермонтов")
  end

  test "удаляет автора" do
    result = Author::Operation::Delete.call(params: { id: @author.id })

    assert result.success?
    assert_nil Author.find_by(id: @author.id)
  end

  test "провал если автор не найден" do
    result = Author::Operation::Delete.call(params: { id: 0 })

    assert result.failure?
    assert_equal ["author not found"], result[:error]
  end
end
