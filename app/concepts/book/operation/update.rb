class Book::Operation::Update < Trailblazer::Operation
  step :find_book
  fail :http_response
  step :validate
  fail :not_valid

  step :persist

  step :validate_authors
  # fail :authors_not_found
  step :assign_author

  def find_book(ctx, params:, **)
    # ctx[:book_id] = params[:book].id
    # or
    ctx[:book] = Book.find_by(id: params[:book_id])

  end

  def http_response(ctx, **)
    ctx[:error] = ['book not found']
  end

  def validate(ctx, params:, **)
    ctx[:book].assign_attributes(params[:book])
    ctx[:book].valid?
  end

  def not_valid(ctx, **)
    ctx[:error] = ctx[:book].errors.full_messages if ctx[:book]
  end

  def persist(ctx, params:, **)
    ctx[:book].save
  end

  def validate_authors(ctx, params:, **)
    ctx['missing authors'] = []
    params[:author_names].each do |author|
      Author&.find_by(name: author) ? next  : ctx['missing authors'] << author
    end
    return true if ctx['missing authors'].empty?
    ctx[:error] = "Сначала добавтье авторов: #{ctx['missing authors'].join(', ')} в БД"
    false
  end

  # def authors_not_found(ctx, **)
  #   false
  # end

  def assign_author(ctx, params:, **)
    ctx[:book].book_authors.destroy_all
    params[:author_names].each do |author|
      BookAuthor.create(author_id: Author.find_by(name: author).id, book_id: ctx[:book].id)
    end
    true
  end

end