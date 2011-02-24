class TransactionsController < ApplicationController
  skip_before_filter :authorize, :only => [:index, :show]
  # GET /transactions
  # GET /transactions.xml
  def index
    @transactions = Transaction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @transactions }
    end
  end

  # GET /transactions/1
  # GET /transactions/1.xml
  def show
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /transactions/new
  # GET /transactions/new.xml
  def new
    @transaction = Transaction.new
    @people = get_person_dropdown
    @books = get_book_dropdown
    @statuses = get_status_dropdown

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @transaction }
    end
  end

  # GET /transactions/1/edit
  def edit
    @transaction = Transaction.find(params[:id])
    @people = get_person_dropdown
    @books = get_book_dropdown
    @statuses = get_status_dropdown
  end

  def create
    #@transaction = Transaction.new(params[:transaction])
    @person = Person.find(params[:transaction][:person_id])
    puts "+++ @person 0: #{@person.inspect}"
    @book = Book.find(params[:transaction][:book_id])
    @status = Status.find(params[:transaction][:status_id])
    
    #@transaction.person = @person
    #@transaction.book = @book

    respond_to do |format|
      #if @transaction.save
      if @person.purchase_transaction(@book, @status)
        puts "+++ @person 1: #{@person.inspect}"
        format.html { redirect_to(transactions_url, :notice => 'Transaction was successfully created.') }
        format.xml  { render :xml => @transaction, :status => :created, :location => @transaction }
      else
        @people = get_person_dropdown
        @books = get_book_dropdown
        @statuses = get_status_dropdown
        format.html { render :action => "new" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end
=begin
  def create
    @transaction = Transaction.new(params[:transaction])
    @person = Person.find(params[:transaction][:person_id])
    @book = Book.find(params[:transaction][:book_id])
    #@status = Status.find(params[:transaction][:status_id])
    
    @transaction.person = @person
    @transaction.book = @book

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully created.') }
        format.xml  { render :xml => @transaction, :status => :created, :location => @transaction }
      else
        @people = get_person_dropdown
        @books = get_book_dropdown
        @statuses = get_status_dropdown
        format.html { render :action => "new" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end
=end

  # PUT /transactions/1
  # PUT /transactions/1.xml
  def update
    @transaction = Transaction.find(params[:id])

    respond_to do |format|
      if @transaction.update_attributes(params[:transaction])
        format.html { redirect_to(@transaction, :notice => 'Transaction was successfully updated.') }
        format.xml  { head :ok }
      else
        @people = get_person_dropdown
        @books = get_book_dropdown
        @statuses = get_status_dropdown
        format.html { render :action => "edit" }
        format.xml  { render :xml => @transaction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.xml
  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy

    respond_to do |format|
      format.html { redirect_to(transactions_url) }
      format.xml  { head :ok }
    end
  end
end
