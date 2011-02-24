require 'spec_helper'

describe User do

  #let(:joel) { User.new :name => "joel", :password => "password" }

=begin
  it "is valid with valid attributes" do
    @joel = User.create! :name => "joel"
    @joel.should be_valid
  end
  it "is not valid without valid name" do
    @joel = User.create! :name => "joel"
    @joel.name = nil
    @joel.should_not be_valid
  end
  it "is unique" do
    @joel = User.create! :name => "joel"
    User.count.should == 1
    expect {
      @anotherjoel = User.create! :name => "joel"
    }.to raise_error(ActiveRecord::RecordInvalid)
    User.count.should == 1
  end
=end
=begin
  describe "#user login" do
    it "is logged in"
  end   
  describe "#add user" do
    user = User.new
  end
=end
end
