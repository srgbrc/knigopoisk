class Author::Operation::Create < Trailblazer::Operation

  step :validate
  fail :author_invalid
  step :persist

  def validate(ctx, params:, **)
    ctx[:author] = Author.new(name: params[:name])
    ctx[:author].valid?
  end

  def author_invalid(ctx, **)
    ctx[:error] = ctx[:author].errors.full_messages
  end

  def persist(ctx, **)
    ctx[:author].save
  end
end