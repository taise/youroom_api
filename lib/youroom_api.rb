require "rubygems"
require "object_extention"
require "oauth"
require 'uri'
require 'net/http'
require 'json'

module Youroom
  # base
  autoload :VERSION, 'youroom_api/version'
  autoload :BASE_URL, 'youroom_api/base_url'
  autoload :Base, 'youroom_api/base'
  autoload :OAuth, 'youroom_api/youroom'
  autoload :Request, 'youroom_api/request'

  autoload :VerifyCredentials, 'youroom_api/request/verify_credentials'
  autoload :ShowAttachment, 'youroom_api/request/show_attachment'

  # relation home
  autoload :HomeTimeline, 'youroom_api/request/timeline'
  autoload :UnreadTimeline, 'youroom_api/request/unread_timeline'
  autoload :RoomTimeline, 'youroom_api/request/room_timeline'
  autoload :MyGroup, 'youroom_api/request/my_group'

  # relation entry
  autoload :Entry, 'youroom_api/request/entry'
  autoload :GetEntry, 'youroom_api/request/get_entry'
  autoload :PostEntry, 'youroom_api/request/post_entry'
  autoload :DestroyEntry, 'youroom_api/request/destroy_entry'

  # relation of read/unread
  autoload :Mark, 'youroom_api/request/mark'
  autoload :MarkRead, 'youroom_api/request/mark_read'
  autoload :MarkUnread, 'youroom_api/request/mark_unread'

  # relation room
  autoload :AddRoom, 'youroom_api/request/add_room' # enterprise only
  autoload :GetRoomList, 'youroom_api/request/get_room_list' # enterprise only

  # relation user
  autoload :AddUser, 'youroom_api/request/add_user' # enterprise only
  autoload :GetUserList, 'youroom_api/request/get_user_list' # enterprise only

  # relation participation
  autoload :Participation, 'youroom_api/request/participation'
  autoload :AddParticipation, 'youroom_api/request/add_participation' # enterprise only
  autoload :DestroyParticipation, 'youroom_api/request/destroy_participation' # enterprise only

  # for picture
  autoload :Picture, 'youroom_api/request/get_picture'
end

