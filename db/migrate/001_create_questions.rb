class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions, :force => true do |t|
      t.string  :body, :null => false
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
