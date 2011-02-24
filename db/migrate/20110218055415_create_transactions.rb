class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.integer :book_id
      t.integer :person_id
      t.integer :status_id

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
