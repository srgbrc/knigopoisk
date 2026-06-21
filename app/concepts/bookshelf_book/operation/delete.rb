class BookshelfBook::Operation::Delete < Trailblazer::Operation
  step :find_bookshelf_book
  fail :bookshelf_book_not_found
  step :delete_bookshelf_book

  def find_bookshelf_book(ctx, params:, current_user:, **)
    ctx[:bookshelf_book] = BookshelfBook
      .joins(:bookshelf)
      .find_by(id: params[:id], bookshelves: { user_id: current_user.id })
  end

  def bookshelf_book_not_found(ctx, **)
    ctx[:error] = ['bookshelf book not found']
  end

  def delete_bookshelf_book(ctx, **)
    ctx[:bookshelf_book].destroy
  end
end
