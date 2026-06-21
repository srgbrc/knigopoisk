require "test_helper"

class Bookshelf::Operation::DeleteTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "shelf_delete@test.com", password: "password123", role: 0)
    @bookshelf = Bookshelf.create!(name: "Полка для удаления", user: @user)
  end

  test "удаляет полку" do
    result = Bookshelf::Operation::Delete.call(
      params: { id: @bookshelf.id },
      current_user: @user
    )

    assert result.success?
    assert_nil Bookshelf.find_by(id: @bookshelf.id)
  end

  test "провал если полка не найдена" do
    result = Bookshelf::Operation::Delete.call(
      params: { id: 0 },
      current_user: @user
    )

    assert result.failure?
    assert_equal ["bookshelf not found"], result[:error]
  end

  test "нельзя удалить чужую полку" do
    other_user = User.create!(email: "other_shelf_del@test.com", password: "password123", role: 0)

    result = Bookshelf::Operation::Delete.call(
      params: { id: @bookshelf.id },
      current_user: other_user
    )

    assert result.failure?
    assert_equal ["bookshelf not found"], result[:error]
  end
end
