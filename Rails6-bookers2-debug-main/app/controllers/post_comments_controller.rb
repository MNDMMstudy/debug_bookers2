class PostCommentsController < ApplicationController
  def create
    @books = Book.find(params[:book_id])
    @post_comment =current_user.post_comments.new(post_comment_params)
    @post_comment.book_id = @books.id
    @post_comment.save
  end

  def destroy
    @books = Book.find(params[:book_id])
    @post_comment = PostComment.find_by(id: params[:id], book_id: params[:book_id])
    @post_comment.destroy
    @post_comment = PostComment.new
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
