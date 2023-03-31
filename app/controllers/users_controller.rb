class UsersController < ApplicationController
  def index
    @user = current_user
    @book = Book.new(book_params)
    @users = User.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book)
    
    @user = User.new(user_params)
    @user.user_id = current_user.id
    @user.save
    redirect_to user_path(@user)
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = @user.books
  end

  def edit
    @user = current_user
  end


  private

  def book_params
    params.permit(:title, :body)
  end

  def user_params
    params.permit(:name, :introduction)
  end
end