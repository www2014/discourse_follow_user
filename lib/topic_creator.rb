TopicCreator.class_eval do

  pp '#######1'

  private

  def watch_topic
    pp '########'
    unless @opts[:auto_track] == false
      @topic.notifier.watch_topic!(@topic.user_id)
    end

    @topic.topic_allowed_users.pluck(:user_id).reject{|id| id == @topic.user_id}.each do |id|
      @topic.notifier.watch_topic!(id, nil)
    end

    CategoryUser.auto_watch_new_topic(@topic)
    FollowUser.auto_watch_new_topic(@topic)
  end
end
