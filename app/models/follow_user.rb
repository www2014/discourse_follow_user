class FollowUser < ActiveRecord::Base
  belongs_to :follower, class_name: "User"
  belongs_to :user

  # same for now
  def self.notification_levels
    TopicUser.notification_levels
  end

  def self.auto_watch_new_topic(topic)
    apply_default_to_topic(
        topic,
        TopicUser.notification_levels[:watching],
        TopicUser.notification_reasons[:auto_watch_category]
    )
  end

  def self.change(follower_id, user_id, notification_level)
    # Sometimes people pass objs instead of the ids. We can handle that.
    follower_id = follower_id.id if follower_id.is_a?(::User)
    user_id = user_id.id if user_id.is_a?(::User)

    return if follower_id == user_id

    FollowUser.transaction do

      rows = FollowUser.where(follower_id: follower_id, user_id: user_id).update_all(notification_level)

      if rows == 0
        FollowUser.create({follower_id: follower_id, user_id: user_id}.merge(notification_level))
      #else
      #  observe_after_save_callbacks_for topic_id, user_id
      end
    end
  rescue ActiveRecord::RecordNotUnique
    # In case of a race condition to insert, do nothing
  end

  private

  def self.apply_default_to_topic(topic, level, reason)


    # Can not afford to slow down creation of topics when a pile of users are watching new topics, reverting to SQL for max perf here
    sql = <<SQL
    INSERT INTO topic_users(user_id, topic_id, notification_level, notifications_reason_id)
    SELECT follower_id, :topic_id, :level, :reason
    FROM follow_users
    WHERE notification_level = :level AND
          user_id = :user_id AND
          NOT EXISTS(SELECT 1 FROM topic_users WHERE topic_id = :topic_id AND user_id = follow_users.follower_id)
SQL

    exec_sql(
        sql,
        topic_id: topic.id,
        user_id: topic.user_id,
        level: level,
        reason: reason
    )
  end

end