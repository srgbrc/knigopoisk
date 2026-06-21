class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can :create, Book
      can :update, Book, creator_id: user.id
      can [:update, :destroy], Bookshelf, user_id: user.id

      can :create, Genre

      can [:create, :update], Author

      can [:create, :update, :destroy], Rating, user_id: user.id
    end
  end
end