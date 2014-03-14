class AddFollowUsers < ActiveRecord::Migration
  def change
    create_table :follow_users do |t|
      t.column :follower_id, :integer, null: false
      t.column :user_id, :integer, null: false
      t.column :notification_level, :integer, null: false
    end
  end
end
