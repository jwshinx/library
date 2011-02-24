require 'spec_helper'

describe "books/edit.html.erb" do
  before(:each) do
    @book = assign(:book, stub_model(Book,
      :title => "MyString",
      :price => 1,
      :author_id => 1,
      :category_id => 1
    ))
  end

  it "renders the edit book form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => books_path(@book), :method => "post" do
      assert_select "input#book_title", :name => "book[title]"
      assert_select "input#book_price", :name => "book[price]"
      assert_select "input#book_author_id", :name => "book[author_id]"
      assert_select "input#book_category_id", :name => "book[category_id]"
    end
  end
end
