class Rating::Operation::Create < Trailblazer::Operation
  step :get_params
  step :validate_cr
  fail :validation_failed
  step :add_rating

  def get_params(ctx, params:, current_user:, **)
    ctx[:rating] = Rating.new(value: params[:rating],user_id: current_user.id, book_id: params[:book_id])
  end


  def validate_cr (ctx, **)
    ctx[:rating].valid?
  end

  def validation_failed(ctx, **)
    ctx[:error] = ctx[:rating].errors.full_messages
  end

  def add_rating(ctx, **)
    ctx[:rating].save
  end
end