class AddStubToProjectsMigration < ActiveRecord::Migration
  def self.up
    add_column :projects, :stub, :string
  end

  def self.down
    remove_column :projects, :stub
  end
end
