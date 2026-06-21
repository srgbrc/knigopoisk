require "test_helper"

class Genre::Operation::UpdateTest < ActiveSupport::TestCase
  setup do
    @genre = Genre.create!(name: "Поэзия")
  end

  test "обновляет жанр" do
    result = Genre::Operation::Update.call(params: { id: @genre.id, name: "Проза" })

    assert result.success?
    assert_equal "Проза", @genre.reload.name
  end

  test "провал если жанр не найден" do
    result = Genre::Operation::Update.call(params: { id: 0, name: "Проза" })

    assert result.failure?
    assert_equal ["genre not found"], result[:error]
  end

  test "провал при пустом имени" do
    result = Genre::Operation::Update.call(params: { id: @genre.id, name: "" })

    assert result.failure?
    assert_not_nil result[:error]
  end
end
