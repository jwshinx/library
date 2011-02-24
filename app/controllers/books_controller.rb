class BooksController < ApplicationController
  skip_before_filter :authorize, :only => [:index, :show]
  # only the listed (cud) do not need authorization
  #skip_before_filter :authorize, :only => [:create, :update, :destroy]
  # no authorization needed. period
  #skip_before_filter :authorize

  # GET /books
  # GET /books.xml
  def index
    @books = Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    @book = Book.new
    @categories = get_category_dropdown 
    @authors = get_author_dropdown

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
    @categories = get_category_dropdown 
    @authors = get_author_dropdown
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])
    
    @author = Author.find(params[:book][:author_id])
    @category = Category.find(params[:book][:category_id])
    @book.author = @author
    @book.category = @category

    respond_to do |format|
      if @book.save
        format.html { redirect_to(@book, :notice => 'Book was successfully created.') }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        @categories = get_category_dropdown 
        @authors = get_author_dropdown
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    @book = Book.find(params[:id])

    @author = Author.find(params[:book][:author_id])
    @category = Category.find(params[:book][:category_id])
    @book.author = @author
    @book.category = @category

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Book was successfully updated.') }
        format.xml  { head :ok }
      else
        @categories = get_category_dropdown 
        @authors = get_author_dropdown
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end
end
