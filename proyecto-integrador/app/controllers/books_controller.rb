class BooksController < ApplicationController
  before_action :set_user
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    @books = @user.books
  end

  # GET /books/1
  def show
  end

  # GET /books/new
  def new
    @book = @user.books.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  def create
    @book = @user.books.new(book_params)

    if @book.save
      redirect_to [@user,@book], notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /books/1
  def update
    if @book.update(book_params)
      redirect_to [@user,@book], notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy
    redirect_to user_books_url, notice: 'Book was successfully destroyed.'
  end

  private

    def set_user
      @user = current_user
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = @user.books.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:user_id, :name)
    end
end
