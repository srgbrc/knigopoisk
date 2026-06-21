class Bookshelf::Operation::Delete < Trailblazer::Operation
  step :find_bookshelf
  fail :bookshelf_not_found
  step :delete_bookshelf

  def find_bookshelf(ctx, params:, current_user:, **)
    ctx[:bookshelf] = current_user.bookshelves.find_by(id: params[:id])
  end

  def bookshelf_not_found(ctx, **)
    ctx[:error] = ['bookshelf not found']
  end

  def delete_bookshelf(ctx, **)
    ctx[:bookshelf].destroy
  end
end
