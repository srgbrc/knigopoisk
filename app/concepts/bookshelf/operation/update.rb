class Bookshelf::Operation::Update < Trailblazer::Operation
  step :find_bookshelf
  fail :bookshelf_not_found
  step :validate
  fail :bookshelf_invalid
  step :persist

  def find_bookshelf(ctx, params:, current_user:, **)
    ctx[:bookshelf] = current_user.bookshelves.find_by(id: params[:id])
  end

  def bookshelf_not_found(ctx, **)
    ctx[:error] = ['bookshelf not found']
  end

  def validate(ctx, params:, **)
    ctx[:bookshelf].assign_attributes(name: params[:name])
    ctx[:bookshelf].valid?
  end

  def bookshelf_invalid(ctx, **)
    ctx[:error] = ctx[:bookshelf].errors.full_messages if ctx[:bookshelf]
  end

  def persist(ctx, **)
    ctx[:bookshelf].save
  end
end
