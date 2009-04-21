class AddSuitableToAnswers < ActiveRecord::Migration
  def self.up
    add_column :answers, :suitable, :boolean, :default => false
  end

  def self.down
    remove_column :answers, :suitable
  end
end
