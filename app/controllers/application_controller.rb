class ApplicationController < ActionController::Base
  before_filter :authorize
  protect_from_forgery
  def get_category_dropdown
    @categories = Category.find(:all, :order => "name ASC").map do |c|
                    [c.name, c.id]
    end
  end
  def get_author_dropdown
    @authors = Author.find(:all, :order => "lastname ASC").map do |c|
                    ["#{c.lastname}, #{c.firstname}", c.id]
    end
  end
  def get_status_dropdown
    @authors = Status.find(:all, :order => "name ASC").map do |c|
                    [c.name, c.id]
    end
  end
  def get_book_dropdown
    @books = Book.find(:all, :order => "title ASC").map do |c|
                    [c.title, c.id]
    end
  end
  def get_person_dropdown
    @books = Person.find(:all, :order => "name ASC").map do |c|
                    [c.name, c.id]
    end
  end
protected
  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
    end 
  end
end
