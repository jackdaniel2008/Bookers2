class UsersController < ApplicationController
  def index
    @user = current_user
    @book = Book.new
    @users = User.page(params[:page])
  end

  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      render :index
    end
    @user_new = User.new(user_params)
    if @user_new.save
      flash[:notice] = "Welcome! You have signed up successfully."
      redirect_to user_path
    else
      render :new
    end
    @user_login = login(params[:name], params[:password])
    if @user_login
      flash[:notice] = "Signed in successfully."
      redirect_to user_path
    else
      render :new
    end
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @books = @user.books.page(params[:page])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user_logout = logout
    if @user_logout
      flash[:notice] = "Signed out successfully."
      redirect_to root_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end
end