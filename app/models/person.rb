class Person < ActiveRecord::Base
  validates :name, :presence => true
  validates :rank, :presence => true
  validates :debt, :presence => true

  has_many :transactions

  def borrow_transaction(book, status)
    if can_borrow_book?
      Transaction.create! :book => book, :status => status, :person => self
    else
      self.errors[:debt] << "Transaction Failed. You have debt."
      false
    end
  end
  def purchase_transaction(book, status)
    if is_credit_worthy? && is_an_admin?
      self.debt += book.price
      self.save
      Transaction.create! :book => book, :status => status, :person => self
    else
      unless is_credit_worthy?
        self.errors[:debt] << "Purchase Transaction Rejected. Bad Credit."
      end
      unless is_an_admin?
        self.errors[:rank] << "Purchase Transaction Rejected. Only Admins."
      end
      false
    end
  end

  def can_borrow_book?
    self.debt > 0 ? false : true
  end
  def is_an_admin?
    self.rank == 'admin' ? true : false
  end
  def is_credit_worthy?
    self.debt < 100 ? true : false
  end
end
