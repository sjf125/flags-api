#
class BooksController < OpenReadController
  before_action :set_book, only: [:update, :destroy]

  # GET /books
  def index
    @books = Book.all

    render json: @books
  end

  # GET /books/1
  def show
    @book = Book.find(params[:id])

    render json: @book
  end

  # POST /books
  def create
    @book = current_user.books.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH /books/1
  def update
    if @book.update(book_params)
      head :no_content
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  def destroy
    @book.destroy

    head :no_content
  end

  def set_book
    @book = current_user.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :isbn)
  end

  private :set_book, :book_params
end
