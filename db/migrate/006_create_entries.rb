class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries, :force => true do |t|
      t.integer :user_id
      t.string :standard_form
      t.integer :language_id

      t.string :transliteration
      t.string :transliteration_2
      t.string :transliteration_3

      t.integer :meaning_language_id
      t.integer :tone_id
      t.integer :gender_id
      t.integer :char_count

      t.timestamps
    end
    
    add_index :entries, [:user_id, :language_id, :transliteration]
    
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

    create_table :chinese_characters, :force => true do |t|
      t.string :character, :limit => 4
      t.string :transliteration, :limit => 10
      t.string :transliteration_2, :limit => 10
      t.string :transliteration_3, :limit => 10
    end
    
    add_index :chinese_characters, [:transliteration, :character]
    add_index :chinese_characters, [:character, :transliteration]
  end

  def self.down
    # remove_index :chinese_characters, [:transliteration, :character]
    # remove_index :chinese_characters, [:character, :transliteration]
    # drop_table :chinese_characters
    
    remove_index :entry_meanings, [:entry_id, :position]
    remove_index :entry_meanings, [:language_id]
    drop_table :entry_meanings

    remove_index :entries, [:user_id, :language_id, :transliteration]
    drop_table :entries 
  end
end
