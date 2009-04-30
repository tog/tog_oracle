class AddTitleToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :title, :string, :null => false
  end

  def self.down
    remove_column :questions, :title
  end
end
