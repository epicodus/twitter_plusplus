class AddIndexesMentions < ActiveRecord::Migration
  def change
    add_index :mentions, :tweet_id
    add_index :mentions, :user_id
  end
end
