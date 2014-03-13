Discourse.UserProfileControlButtonsView.reopen({
  addUserFollowButton: function() {
    var user = this.get('user');
    var currentUser = Discourse.User.current();
    if((currentUser && user.id !== currentUser.id)){
      this.attachViewClass(Discourse.FollowUserButton);
    }
  }.on("additionalUserControlButtons")
});