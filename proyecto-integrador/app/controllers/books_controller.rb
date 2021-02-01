class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :set_book_export_notes , only: [:export_book_notes]

  # GET /books
  def index
    @books = @user.books
  end

  # GET /books/1
  def show
    redirect_to user_book_notes_path(@user,@book)
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
      redirect_to user_books_path(@user,@book), notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /books/1
  def destroy
    if ((@book.name != "Global Book") || (@book.id != 1))
        @book.destroy
        redirect_to user_books_url, notice: 'Book was successfully destroyed.'
    else
        redirect_to user_books_url, alert: "Global Book cant't be deleted."
    end
  end

  def export_book_notes
  end

  private

    def set_user
      @user = current_user
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = @user.books.find(params[:id])
    end

    def set_book_export_notes
      @book = @user.books.find(params[:book_id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:user_id, :name)
    end
end
