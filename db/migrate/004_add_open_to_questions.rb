class AddOpenToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :open, :boolean, :default => true
  end

  def self.down
    remove_column :questions, :open
  end
end
