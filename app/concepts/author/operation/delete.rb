class Author::Operation::Delete < Trailblazer::Operation
  step :find_author
  fail :author_not_found
  step :delete_author

  def find_author(ctx, params:, **)
    ctx[:author] = Author.find_by(id: params[:id])
  end

  def author_not_found(ctx, **)
    ctx[:error] = ['author not found']
  end

  def delete_author(ctx, **)
    ctx[:author].destroy
  end
end