require 'spec_helper'

describe "transactions/new.html.erb" do
  before(:each) do
    assign(:transaction, stub_model(Transaction,
      :book_id => 1,
      :person_id => 1,
      :status_id => 1
    ).as_new_record)
  end

  it "renders new transaction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => transactions_path, :method => "post" do
      assert_select "input#transaction_book_id", :name => "transaction[book_id]"
      assert_select "input#transaction_person_id", :name => "transaction[person_id]"
      assert_select "input#transaction_status_id", :name => "transaction[status_id]"
    end
  end
end
