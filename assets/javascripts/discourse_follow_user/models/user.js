Discourse.User.reopenClass({
  NotificationLevel: {
    WATCHING: 3,
    TRACKING: 2,
    REGULAR: 1,
    MUTED: 0
  }
});

Discourse.User.reopen({

  updateNotifications: function(v) {
    this.set('notification_level', v);
    this.set('notifications_reason_id', null);
    return Discourse.ajax("/users/" + (this.get('username')) + "/follow", {
      type: 'POST',
      data: { notification_level: v }
    });
  }

});