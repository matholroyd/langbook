class CreateDecks < ActiveRecord::Migration
  def self.up
    create_table :decks do |t|
      t.string :name
      t.integer :user_id
      
      t.timestamps
    end
    
    add_index :decks, :user_id
  end

  def self.down
    drop_table :decks
  end
end
