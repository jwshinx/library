class Book < ActiveRecord::Base
  validates :author, :presence => true 
  validates :category, :presence => true 
  validates :price, :presence => true 
  validates :title, :presence => true 

  belongs_to :author
  belongs_to :category
  has_many :comments
end
