Rails.application.routes.draw do

  match "users/:id/follow", to: 'follow_users#follow', via: [:post]

end
