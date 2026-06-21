class Bookshelf::Operation::Create < Trailblazer::Operation
  step :validate
  fail :bookshelf_invalid
  step :persist

  def validate(ctx, params:, current_user:, **)
    ctx[:bookshelf] = Bookshelf.new(name: params[:name], user: current_user)
    ctx[:bookshelf].valid?
  end

  def bookshelf_invalid(ctx, **)
    ctx[:error] = ctx[:bookshelf].errors.full_messages
  end

  def persist(ctx, **)
    ctx[:bookshelf].save
  end
end
