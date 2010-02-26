class AddLastStudiedField < ActiveRecord::Migration
  def self.up
    change_table :cards do |t|
      t.date :last_studied 
    end

    change_table :users do |t|
      t.integer :daily_card_quota
    end
    
    User.all.each { |user| user.update_attributes(:daily_card_quota => 30) }
    
    add_index :cards, [:deck_id, :last_studied, :next_repetition]
  end

  def self.down
    remove_index :cards, [:deck_id, :last_studied, :next_repetition]

    change_table :cards do |t|
      t.remove :last_studied
    end

    change_table :users do |t|
      t.remove :daily_card_quota
    end
  end
end
