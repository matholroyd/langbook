class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries, :force => true do |t|
      t.integer :user_id
      t.string :standard_form
      t.string :pronounciation
      t.string :pronounciation_2
      t.string :pronounciation_3

      t.integer :language_id
      t.integer :tone_id
      t.integer :gender_id
      t.integer :char_count

      t.timestamps
    end
    
    add_index :entries, [:user_id, :language_id, :pronounciation]
    add_index :entries, [:pronounciation, :language_id, :user_id]
    add_index :entries, [:language_id, :pronounciation, :user_id]
    
    create_table :entry_meanings, :force => true do |t|
      t.integer :entry_id
      t.integer :position
      t.text :meaning
      t.integer :language_id
      t.text :tag_list_cache 

      t.timestamps
    end
    
    add_index :entry_meanings, [:entry_id, :position]
    add_index :entry_meanings, [:language_id]
  end

  def self.down
    remove_index :entry_meanings, [:entry_id, :position]
    remove_index :entry_meanings, [:language_id]
    drop_table :entry_meanings

    remove_index :entries, [:user_id, :language_id, :pronounciation]
    remove_index :entries, [:pronounciation, :language_id, :user_id]
    remove_index :entries, [:language_id, :pronounciation, :user_id]
    drop_table :entries 
  end
end
