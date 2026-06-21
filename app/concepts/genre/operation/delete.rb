class Genre::Operation::Delete < Trailblazer::Operation
  step :find_genre
  fail :genre_not_found
  step :nullify_books
  step :delete_genre

  def find_genre(ctx, params:, **)
    ctx[:genre] = Genre.find_by(id: params[:id])
  end

  def genre_not_found(ctx, **)
    ctx[:error] = ['genre not found']
  end

  def nullify_books(ctx, **)
    ctx[:genre].books.update_all(genre_id: nil)
  end

  def delete_genre(ctx, **)
    ctx[:genre].destroy
  end
end
