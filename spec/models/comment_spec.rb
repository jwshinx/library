require 'spec_helper'

describe Comment do
  describe "#validity" do
    before(:each) do
      @comment = Comment.new :user => mock_model("User"),
                 :book => mock_model("Book"),
                 :text => "what an adventure."
    end
    it "is a valid comment with valid attributes" do
      @comment.should be_valid
    end
    it "is not a valid comment with no user" do
      @comment.user = nil
      @comment.should_not be_valid
    end
    it "is not a valid comment with no book" do
      @comment.book = nil
      @comment.should_not be_valid
    end
    it "is not a valid comment with no text" do
      @comment.text = nil
      @comment.should_not be_valid
    end
  end
  describe "#create comment" do
    before(:each) do
      @bible = Book.create! :title => "bible", :price => 300,
                 :author => mock_model("Author"), 
                 :category => mock_model("Category")      
      puts ">>> 0. @bible.comments: #{@bible.comments.empty?}"
      @comment = Comment.new :user => mock_model("User"),
                 :book => @bible,
                 :text => "what an adventure."
      
      puts ">>> 1. @bible.comments: #{@bible.comments.empty?}"
      puts ">>> 2. @comment.book.title: #{@comment.book.title}"
      @bible.comments.length.should == 1
      
    end
    it "is associated with book" do
   
    end
  end
end
