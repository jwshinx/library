require 'spec_helper'

describe Book do
  before(:each) do
    @book = Book.new(:title => 'how to draw', :price => 10,
                    :author => mock_model("Author"), 
                    :category => mock_model("Category"))
  end
  it "is a valid with valid attributes" do
    @book.should be_valid
  end
  it "is not valid without an author" do
    @book.author = nil
    @book.should_not be_valid
  end
  it "is not valid without a price" do
    @book.price = nil
    @book.should_not be_valid
  end
  it "is not valid without a title " do
    @book.title = nil
    @book.should_not be_valid
  end
  it "is not valid without a category" do
    @book.category = nil
    @book.should_not be_valid
  end
end
