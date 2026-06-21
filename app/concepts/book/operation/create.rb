class Book::Operation::Create < Trailblazer::Operation
  step :create_book
  step :validate
  step :persist
  step :assign_author

  def create_book(ctx,current_user:, params:, **)
    ctx[:book] = Book.new(params[:book])
    ctx[:book].creator_id = current_user
  end

  def validate(ctx, params:, **)
    ctx[:book].valid?
  end

  def persist(ctx, **)
    ctx[:book].save
  end

  def assign_author(ctx, params:, **)
    params[:author_names]&.each do |author|
      BookAuthor.create(book_id: ctx[:book].id, author_id: Author.find_by(name: author)&.id)
    end
    true
  end
end