require 'spec_helper'

describe Status do
  before(:each) do
    @status = Status.new(:name => "available")
  end
  it "is valid with valid attributes" do
    @status.should be_valid
  end
  it "is not valid without a name" do
    @status.name = nil
    @status.should_not be_valid
  end
  it "is not valid if not unique" do
    @status1 = Status.create!(:name => "available")
    lambda { Status.create!(:name => "available") }.should raise_error
  end
end

