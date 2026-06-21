class Book::Operation::Delete < Trailblazer::Operation
  step :find_book
  fail :book_not_found
  step :delete_book

  def find_book(ctx, params:, **)
    ctx[:book] = Book.find_by(id: params[:book_id])
  end

  def book_not_found(ctx, **)
    ctx[:error] = ['book not found']
  end

  def delete_book(ctx, **)
    ctx[:book].destroy
  end
end