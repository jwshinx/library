require 'spec_helper'

describe Author do
  before(:each) do
    @author = Author.new(:firstname => "mark", :lastname => "twain")
  end
  it "is valid with valid attributes" do
    @author.should be_valid
  end
  it "is not valid without a firstname" do
    @author.firstname = nil
    @author.should_not be_valid
  end
  it "is not valid without a lastname" do
    @author.lastname = nil
    @author.should_not be_valid
  end
end
