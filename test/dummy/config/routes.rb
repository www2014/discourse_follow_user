Rails.application.routes.draw do

  mount DiscourseFollowUser::Engine => "/discourse_follow_user"
end
