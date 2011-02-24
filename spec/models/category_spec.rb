require 'spec_helper'

describe Category do
  before(:each) do
    @category = Category.new(:name => "art", :description => "arty books")
  end
  it "is valid with valid attributes" do
    @category.should be_valid
  end
  it "is not valid without a name" do
    @category.name = nil
    @category.should_not be_valid
  end
  it "is not valid without a description" do
    @category.description = nil
    @category.should_not be_valid
  end
end
