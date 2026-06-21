class Rating::Operation::Delete < Trailblazer::Operation
  step :find_rating
  fail :rating_not_found
  step :delete_rating

  def find_rating(ctx, params:, current_user:, **)
    ctx[:rating] = Rating.find_by(book_id: params[:book_id], user_id: current_user.id)
  end

  def rating_not_found(ctx, **)
    ctx[:error] = ['rating not found']
  end

  def delete_rating(ctx, **)
    ctx[:rating].destroy
  end
end