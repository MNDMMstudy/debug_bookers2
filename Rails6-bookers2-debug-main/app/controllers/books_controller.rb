class BooksController < ApplicationController

  before_action :ensure_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.new
    @books = Book.find(params[:id])
    @user = @books.user
    @post_comment = PostComment.new
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else

      render 'books/index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    @user = current_user.id
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    flash[:notice] = " Book was successfully destroyed."
    @books = Book.find(params[:id])
    @books.destroy
    redirect_to books_path
  end

private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_user
    @user = Book.find(params[:id]).user
    unless @user == current_user
      redirect_to '/books'
    end
  end


end
