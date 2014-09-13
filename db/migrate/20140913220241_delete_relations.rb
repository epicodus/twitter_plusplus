class DeleteRelations < ActiveRecord::Migration
  def change
    drop_table :relations
    drop_table :relationships
  end
end
