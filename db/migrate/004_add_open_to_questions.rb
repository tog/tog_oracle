class AddOpenToQuestions < ActiveRecord::Migration
  def self.up
    add_column :questions, :opened, :boolean, :default => true
  end

  def self.down
    remove_column :questions, :opened
  end
end
