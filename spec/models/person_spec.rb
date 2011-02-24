require 'spec_helper'

describe Person do
  def create_status
    @lent = Status.create! :name => "lent"
  end
  def create_book
    @classic = Category.create! :name => "classic", :description => "old"
    @god = Author.create! :firstname => "jon", :lastname => "jehovah"
    @bible = Book.create!( 
                 :title => "bible", :price => 100, 
                 :author => @god, :category => @classic
    )
  end
  before(:each) do
    @person = Person.new(:name => 'joel', :rank => 'admin',
                         :debt => 0)
  end
  it "is valid with valid attributes" do
    @person.should be_valid
  end
  it "is not valid without a name" do
    @person.name = nil
    @person.should_not be_valid
  end
  it "is not valid without a rank" do
    @person.rank = nil
    @person.should_not be_valid
  end
  it "is not valid without a debt" do
    @person.debt = nil
    @person.should_not be_valid
  end

  describe "#purchase_transaction" do
    before(:each) do
      @mike = Person.create! :name => "mike", :rank => "admin", :debt => 0
      @bible = create_book
      @sold = create_status
    end
    context "by a non-credit-worthy non-admin" do
      it "creates no purchase transaction" do
        @mike.debt = 250 
        @mike.rank = "student"
        @mike.purchase_transaction(@bible, @sold).should_not be_true
        @mike.errors[:debt][0].should == "Purchase Transaction Rejected. Bad Credit."
        @mike.errors[:rank][0].should == "Purchase Transaction Rejected. Only Admins."
        #expect {
        #  @message = @mike.purchase_transaction(@bible, @sold)
        #}.to change{ @mike.transactions.count }.by(0)
        #@message.should == "Purchase Transaction Rejected. Bad Credit. Only Admins." 
      end
    end
    context "by a non-credit-worthy admin" do
      it "creates no purchase transaction" do
        @mike.debt = 250
        @mike.purchase_transaction(@bible, @sold).should_not be_true
        @mike.errors[:debt][0].should == "Purchase Transaction Rejected. Bad Credit."
        @mike.errors[:rank].length.should == 0
      end
    end
    context "by a credit-worthy non-admin" do
      it "creates no purchase transaction" do
        @mike.rank = "student"
        @mike.purchase_transaction(@bible, @sold).should_not be_true
        @mike.errors[:debt].length.should == 0
        @mike.errors[:rank][0].should == "Purchase Transaction Rejected. Only Admins."
      end
    end
    context "by a credit-worthy admin" do
      it "creates purchase transaction" do
        @mike.purchase_transaction(@bible, @sold).should be_true
      end
      it "adds debt by purchase price" do
        expect {
          @mike.purchase_transaction(@bible, @sold).should be_true
        }.to change{ @mike.debt }.by(@bible.price)
      end
    end
  end
  describe "#can_purchase_book" do
    context "when a person is an admin" do
      it "returns true" do
        @jill = Person.create! :name => "jill", :rank => "admin", :debt => 0
        @jill.is_an_admin?.should be_true
      end
    end
    context "when a person is not admin" do
      it "returns false" do
        @jill = Person.create! :name => "jill", :rank => "student", :debt => 0
        @jill.is_an_admin?.should be_false
      end
    end
    context "when an admin has less than 100 in debt" do
      it "returns true" do
        @jill = Person.create! :name => "jill", :rank => "admin", :debt => 50
        @jill.is_credit_worthy?.should be_true
      end
    end
    context "when an admin has more than or equal to 100 in debt" do
      it "returns false" do
        @jill = Person.create! :name => "jill", :rank => "admin", :debt => 150
        @jill.is_credit_worthy?.should be_false
      end
    end
  end
  describe "#can_borrow_book" do
    before(:each) do
      @thom = Person.create! :name => "thom", :rank => "student", :debt => 0
    end
    context "when a person does not have debt" do
      it "returns true" do
        @thom.debt = 0 
        @thom.can_borrow_book?.should be_true
      end
    end
    context "when a person does have debt" do
      it "returns false" do
        @thom.debt = 5 
        @thom.can_borrow_book?.should be_false
      end
    end
  end
  describe "#borrow book" do
    before(:each) do
      @joel = Person.create! :name => "joel", :rank => "admin"
      @lent = create_status
      @bible = create_book
    end
    context "when the user does have debt" do
      it "can not borrow a book" do
        @joel.debt = 5
        @joel.borrow_transaction(@bible, @lent).should_not be_true
        #puts ">>>> @joel.errors[:debt] #{@joel.errors[:debt]}"
        @joel.errors[:debt][0].should == "Transaction Failed. You have debt."
      end
    end
    context "when the user does not have debt" do
      it "can borrow a book" do
        @joel.debt = 0 
        @joel.borrow_transaction(@bible, @lent).should be_true
        #puts ">>>> @joel.errors[:debt] #{@joel.errors[:debt]}"
        
=begin
        lambda { joel.borrow_transaction(:book => bible,
                                         :status => lent,
                                         :person => joel
                 )
        }.should change(Transaction, :count)
=end
      end
    end
  end
end
