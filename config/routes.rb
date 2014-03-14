Rails.application.routes.draw do

  match "users/:username/follow", to: 'follow_users#follow', via: [:post]

end
