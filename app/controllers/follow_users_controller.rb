class FollowUsersController < UsersController

  def follow
    user = fetch_user_from_params
    FollowUser.change(current_user.id, user.id, notification_level: params[:notification_level].to_i)
  end

end