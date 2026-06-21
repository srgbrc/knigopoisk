require "test_helper"

class Bookshelf::Operation::UpdateTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(email: "shelf_update@test.com", password: "password123", role: 0)
    @bookshelf = Bookshelf.create!(name: "Старое название полки", user: @user)
  end

  test "обновляет имя полки" do
    result = Bookshelf::Operation::Update.call(
      params: { id: @bookshelf.id, name: "Новое название" },
      current_user: @user
    )

    assert result.success?
    assert_equal "Новое название", @bookshelf.reload.name
  end

  test "провал если полка не найдена" do
    result = Bookshelf::Operation::Update.call(
      params: { id: 0, name: "Новое" },
      current_user: @user
    )

    assert result.failure?
    assert_equal ["bookshelf not found"], result[:error]
  end

  test "нельзя обновить чужую полку" do
    other_user = User.create!(email: "other_shelf@test.com", password: "password123", role: 0)

    result = Bookshelf::Operation::Update.call(
      params: { id: @bookshelf.id, name: "Захваченная полка" },
      current_user: other_user
    )

    assert result.failure?
    assert_equal ["bookshelf not found"], result[:error]
  end

  test "провал при пустом имени" do
    result = Bookshelf::Operation::Update.call(
      params: { id: @bookshelf.id, name: "" },
      current_user: @user
    )

    assert result.failure?
    assert_not_nil result[:error]
  end
end
