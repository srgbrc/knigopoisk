class Genre::Operation::Update < Trailblazer::Operation
  step :find_genre
  fail :genre_not_found
  step :validate
  fail :genre_invalid
  step :persist

  def find_genre(ctx, params:, **)
    ctx[:genre] = Genre.find_by(id: params[:id])
  end

  def genre_not_found(ctx, **)
    ctx[:error] = ['genre not found']
  end

  def validate(ctx, params:, **)
    ctx[:genre].assign_attributes(name: params[:name])
    ctx[:genre].valid?
  end

  def genre_invalid(ctx, **)
    ctx[:error] = ctx[:genre].errors.full_messages if ctx[:genre]
  end

  def persist(ctx, **)
    ctx[:genre].save
  end
end
