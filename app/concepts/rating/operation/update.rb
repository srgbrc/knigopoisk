class Rating::Operation::Update < Trailblazer::Operation
  step :find_rating
  fail :rating_not_found
  step :validate
  fail :rating_invalid
  step :persist

  def find_rating(ctx, params:, current_user:, **)
    ctx[:rating] = Rating.find_by(book_id: params[:book_id], user_id: current_user.id)
  end

  def rating_not_found(ctx, **)
    ctx[:error] = ['rating not found']
  end

  def validate(ctx, params:, **)
    ctx[:rating].value = params[:value]
    ctx[:rating].valid?
  end

  def rating_invalid(ctx, **)
    ctx[:error] = ctx[:rating].errors.full_messages if ctx[:rating]
  end

  def persist(ctx, **)
    ctx[:rating].save
  end
end