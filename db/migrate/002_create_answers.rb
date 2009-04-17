class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers, :force => true do |t|
      t.string :body, :null => false
      t.integer :question_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
