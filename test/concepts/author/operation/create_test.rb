require "test_helper"

class Author::Operation::CreateTest < ActiveSupport::TestCase
  test "создаёт автора с валидным именем" do
    result = Author::Operation::Create.call(params: { name: "Достоевский" })

    assert result.success?
    assert_not_nil result[:author]
    assert result[:author].persisted?
    assert_equal "Достоевский", result[:author].name
  end

  test "провал при пустом имени" do
    result = Author::Operation::Create.call(params: { name: "" })

    assert result.failure?
    assert_not_nil result[:error]
  end

  test "провал при имени на латинице" do
    result = Author::Operation::Create.call(params: { name: "Dostoevsky" })

    assert result.failure?
    assert_not_nil result[:error]
  end

  test "провал при дублирующемся имени" do
    Author::Operation::Create.call(params: { name: "Чехов" })
    result = Author::Operation::Create.call(params: { name: "Чехов" })

    assert result.failure?
    assert_not_nil result[:error]
  end

  test "имя с дефисом допустимо" do
    result = Author::Operation::Create.call(params: { name: "Салтыков-Щедрин" })

    assert result.success?
  end
end
