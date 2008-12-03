class HeartMigration < ActiveRecord::Migration
  def self.up
    create_table :hearts do |t|
      t.integer :user_id
      t.integer :project_id
      t.timestamps
    end
  end

  def self.down
    drop_table :hearts
  end
end
