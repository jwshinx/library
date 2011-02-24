class Transaction < ActiveRecord::Base
  belongs_to :book
  belongs_to :person
  belongs_to :status
  
  validates :book, :presence => true
  validates :person, :presence => true
  validates :status, :presence => true
end
