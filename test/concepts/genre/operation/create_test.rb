require "test_helper"

class Genre::Operation::CreateTest < ActiveSupport::TestCase
  test "создаёт жанр" do
    result = Genre::Operation::Create.call(params: { name: "Роман" })

    assert result.success?
    assert result[:genre].persisted?
    assert_equal "Роман", result[:genre].name
  end

  test "провал при пустом имени" do
    result = Genre::Operation::Create.call(params: { name: "" })

    assert result.failure?
    assert_not_nil result[:error]
  end

  test "провал при nil имени" do
    result = Genre::Operation::Create.call(params: { name: nil })

    assert result.failure?
    assert_not_nil result[:error]
  end
end
