class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book
  validates :user, :presence => true
  validates :book, :presence => true
  validates :text, :presence => true
end
