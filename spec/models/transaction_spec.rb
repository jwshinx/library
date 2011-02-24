require 'spec_helper'

describe Transaction do
  before(:each) do
    @t = Transaction.new(:book => mock_model("Book"),
                        :person => mock_model("Person"),
                        :status => mock_model("Status"))
  end
  it "is valid with valid attributes" do
    @t.should be_valid
  end
  it "is not valid without a book attributes" do
    @t.book = nil
    @t.should_not be_valid
  end
  it "is not valid without a person attributes" do
    @t.person = nil
    @t.should_not be_valid
  end
  it "is not valid without a status attributes" do
    @t.status = nil
    @t.should_not be_valid
  end
end
