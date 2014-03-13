Discourse.FollowUserButton = Discourse.DropdownButtonView.extend({
  classNames: ['left', 'notification-options'],
  textKey: 'follow_user.button.text',
  title: I18n.t('follow_user.button.help'),

  dropDownContent: function() {
    var contents = [], postfix = '';

    _.each([
      ['WATCHING', 'watching'],
      ['TRACKING', 'tracking'],
      ['REGULAR', 'regular'],
      ['MUTED', 'muted']
    ], function(pair) {

      contents.push([
        Discourse.User.NotificationLevel[pair[0]],
          'user.notifications.' + pair[1] + postfix
      ]);
    });

    return contents;
  }.property(),

  text: function() {
    var key = (function() {
      switch (this.get('user.notification_level')) {
        case Discourse.User.NotificationLevel.WATCHING: return 'watching';
        case Discourse.User.NotificationLevel.TRACKING: return 'tracking';
        case Discourse.User.NotificationLevel.MUTED: return 'muted';
        default: return 'regular';
      }
    }).call(this);

    var icon = (function() {
      switch (key) {
        case 'watching': return '<i class="fa fa-circle heatmap-high"></i>&nbsp;';
        case 'tracking': return '<i class="fa fa-circle heatmap-low"></i>&nbsp;';
        case 'muted': return '<i class="fa fa-times-circle"></i>&nbsp;';
        default: return '';
      }
    })();
    return icon + (I18n.t("user.notifications." + key + ".title")) + "<span class='caret'></span>";
  }.property('user.notification_level'),

  clicked: function(id) {
    var user = this.get('controller.model');
    user.updateNotifications(id);
  },

  render: function(buffer) {
    buffer.push("<button class='btn standard dropdown-toggle' data-toggle='dropdown'>");
    buffer.push(this.get('text'));
    buffer.push("</button>");
    buffer.push("<ul class='dropdown-menu'>");

    _.each(this.get('dropDownContent'), function(row) {
      var id = row[0],
        textKey = row[1],
        title = I18n.t(textKey + ".title"),
        description = I18n.t(textKey + ".description");

      buffer.push("<li data-id=\"" + id + "\"><a href='#'>");
      buffer.push("<span class='title'>" + title + "</span>");
      buffer.push("<span>" + description + "</span>");
      buffer.push("</a></li>");
    });
    buffer.push("</ul>");

    var desc = this.get('longDescription');
    if (desc) {
      buffer.push("<p>");
      buffer.push(desc);
      buffer.push("</p>");
    }
  }
});