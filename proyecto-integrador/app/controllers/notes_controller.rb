class NotesController < ApplicationController
  before_action :set_user
  before_action :set_book
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  def index
    @notes = @book.notes
  end

  # GET /notes/1
  def show
  end

  # GET /notes/new
  def new
    @note = @book.notes.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  def create
    @note = @book.notes.new(note_params)

    if @note.save
      redirect_to [@user,@book,@note], notice: 'Note was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      redirect_to [@user,@book,@note], notice: 'Note was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
    redirect_to user_book_notes_url, notice: 'Note was successfully destroyed.'
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_book
      @book = Book.find(params[:book_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = @book.notes.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:book_id, :title, :content)
    end
end
