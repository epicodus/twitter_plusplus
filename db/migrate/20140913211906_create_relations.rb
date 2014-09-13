class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.belongs_to :user
      t.integer :follower_id
      t.boolean :blocked, :default => false
    end
  end
end
