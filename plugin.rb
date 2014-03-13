# name: discourse_follow_user
# about: discourse_follow_user
# version: 0.0.1
# authors: Piotr Szal

# load the engine definition, which is in a separate file so that script/rails can use it
require File.expand_path('../lib/discourse_follow_user/engine', __FILE__)

register_asset('javascripts/discourse_follow_user.js', :server_side)
register_asset('stylesheets/discourse_follow_user.css')
