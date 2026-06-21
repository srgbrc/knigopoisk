require "test_helper"

class AbilityTest < ActiveSupport::TestCase
  def setup
    @user       = users(:one)
    @other_user = users(:two)
    @admin      = users(:admin)

    @own_book       = books(:one)   # creator: one
    @other_book     = books(:two)   # creator: two

    @own_bookshelf   = bookshelves(:one)  # user: one
    @other_bookshelf = bookshelves(:two)  # user: two

    @own_rating   = ratings(:one)   # user: one
    @other_rating = ratings(:two)   # user: two
  end

  # --- Admin ---

  test "admin can manage everything" do
    ability = Ability.new(@admin)
    assert ability.can?(:manage, :all)
  end

  # --- Book ---

  test "user can create book" do
    ability = Ability.new(@user)
    assert ability.can?(:create, Book)
  end

  test "user can update own book" do
    ability = Ability.new(@user)
    assert ability.can?(:update, @own_book)
  end

  test "user cannot update someone else's book" do
    ability = Ability.new(@user)
    assert ability.cannot?(:update, @other_book)
  end

  test "user cannot destroy book" do
    ability = Ability.new(@user)
    assert ability.cannot?(:destroy, @own_book)
  end

  # --- Bookshelf ---

  test "user can update own bookshelf" do
    ability = Ability.new(@user)
    assert ability.can?(:update, @own_bookshelf)
  end

  test "user can destroy own bookshelf" do
    ability = Ability.new(@user)
    assert ability.can?(:destroy, @own_bookshelf)
  end

  test "user cannot update someone else's bookshelf" do
    ability = Ability.new(@user)
    assert ability.cannot?(:update, @other_bookshelf)
  end

  test "user cannot destroy someone else's bookshelf" do
    ability = Ability.new(@user)
    assert ability.cannot?(:destroy, @other_bookshelf)
  end

  # --- Genre ---

  test "user can create genre" do
    ability = Ability.new(@user)
    assert ability.can?(:create, Genre)
  end

  test "user cannot update genre" do
    ability = Ability.new(@user)
    assert ability.cannot?(:update, Genre)
  end

  # --- Author ---

  test "user can create author" do
    ability = Ability.new(@user)
    assert ability.can?(:create, Author)
  end

  test "user can update author" do
    ability = Ability.new(@user)
    assert ability.can?(:update, Author)
  end

  test "user cannot destroy author" do
    ability = Ability.new(@user)
    assert ability.cannot?(:destroy, Author)
  end

  # --- Rating ---

  test "user can create rating" do
    ability = Ability.new(@user)
    assert ability.can?(:create, Rating)
  end

  test "user can update own rating" do
    ability = Ability.new(@user)
    assert ability.can?(:update, @own_rating)
  end

  test "user can destroy own rating" do
    ability = Ability.new(@user)
    assert ability.can?(:destroy, @own_rating)
  end

  test "user cannot update someone else's rating" do
    ability = Ability.new(@user)
    assert ability.cannot?(:update, @other_rating)
  end

  test "user cannot destroy someone else's rating" do
    ability = Ability.new(@user)
    assert ability.cannot?(:destroy, @other_rating)
  end
end
