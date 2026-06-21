class Genre::Operation::Create < Trailblazer::Operation
  step :validate
  fail :genre_invalid
  step :persist

  def validate(ctx, params:, **)
    ctx[:genre] = Genre.new(name: params[:name])
    ctx[:genre].valid?
  end

  def genre_invalid(ctx, **)
    ctx[:error] = ctx[:genre].errors.full_messages
  end

  def persist(ctx, **)
    ctx[:genre].save
  end
end