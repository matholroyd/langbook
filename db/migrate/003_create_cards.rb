class CreateCards < ActiveRecord::Migration
  def self.up
    create_table :cards do |t|
      t.integer :deck_id
      t.text :question
      t.text :answer

      t.float :easiness_factor
      t.integer :number_repetitions 
      t.integer :quality_of_last_recall 
      t.integer :repetition_interval
      t.date :next_repetition

      t.timestamps
    end
    
    add_index :cards, [:deck_id, :next_repetition]
    add_index :cards, [:next_repetition, :deck_id]
  end

  def self.down
    drop_table :cards
  end
end
