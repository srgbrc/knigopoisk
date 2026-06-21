class Author::Operation::Update < Trailblazer::Operation
  step :find_author
  fail :author_not_found
  step :update_author
  fail :author_invalid

  def find_author(ctx, params:, **)
    ctx[:author] = Author.find_by(id: params[:id])
  end

  def author_not_found(ctx, **)
    ctx[:error] = ['author not found']
  end

  def update_author(ctx, params:, **)
    ctx[:author].update(params[:author])
  end

  def author_invalid(ctx, **)
    ctx[:error] = ctx[:author].errors.full_messages if ctx[:author]
  end
end

