class AddFormmattedFields < ActiveRecord::Migration
  def self.up
    change_table :cards do |t|
      t.text :question_formatted
      t.text :answer_formatted
    end
    
    Card.all.each &:save!
  end

  def self.down
    change_table :cards do |t|
      t.remove :question_formatted
      t.remove :answer_formatted
    end
  end
end
