require "test_helper"

class Bookshelf::Operation::CreateTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "shelf_create@test.com", password: "password123", role: 0)
  end

  test "создаёт полку" do
    result = Bookshelf::Operation::Create.call(
      params: { name: "Любимые книги" },
      current_user: @user
    )

    assert result.success?
    assert result[:bookshelf].persisted?
    assert_equal "Любимые книги", result[:bookshelf].name
    assert_equal @user.id, result[:bookshelf].user_id
  end

  test "провал при пустом имени" do
    result = Bookshelf::Operation::Create.call(
      params: { name: "" },
      current_user: @user
    )

    assert result.failure?
    assert_not_nil result[:error]
  end

  test "провал при nil имени" do
    result = Bookshelf::Operation::Create.call(
      params: { name: nil },
      current_user: @user
    )

    assert result.failure?
    assert_not_nil result[:error]
  end
end
