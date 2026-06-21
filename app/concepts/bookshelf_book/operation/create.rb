class BookshelfBook::Operation::Create < Trailblazer::Operation
  step :find_bookshelf
  fail :bookshelf_not_found
  step :find_book
  fail :book_not_found
  step :check_not_duplicate
  fail :already_in_bookshelf
  step :persist

  def find_bookshelf(ctx, params:, current_user:, **)
    ctx[:bookshelf] = current_user.bookshelves.find_by(id: params[:bookshelf_id])
  end

  def bookshelf_not_found(ctx, **)
    ctx[:error] = ['bookshelf not found']
  end

  def find_book(ctx, params:, **)
    ctx[:book] = Book.find_by(id: params[:book_id])
  end

  def book_not_found(ctx, **)
    ctx[:error] = ['book not found'] if ctx[:bookshelf]
  end

  def check_not_duplicate(ctx, **)
    !BookshelfBook.exists?(bookshelf: ctx[:bookshelf], book: ctx[:book])
  end

  def already_in_bookshelf(ctx, **)
    ctx[:error] = ['book already in bookshelf'] if ctx[:bookshelf] && ctx[:book]
  end

  def persist(ctx, **)
    ctx[:bookshelf_book] = BookshelfBook.create(bookshelf: ctx[:bookshelf], book: ctx[:book])
    ctx[:bookshelf_book].persisted?
  end
end
