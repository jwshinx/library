Given /^a book$/ do
  @book = Book.new
  #@book = Book.create! :title => 'moby dick', :price => 25,
  #                     :author => Author"),
  #                     :category => mock_model("Category")
end

When /^a comment is added$/ do
  @comment = Comment.new
  @book.comments << @comment
end

Then /^the book has an associated comment$/ do
  pending
end
