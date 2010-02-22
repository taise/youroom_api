require 'object_extention'
require 'uri'
require 'net/http'
require File.expand_path(File.dirname(__FILE__)+"/youroom_oauth.rb")

module Youroom
  # you need override here
  MUIT_DEV_URL = "http://172.31.235.77:8081/youroom/"
  MUIT_URL = "http://172.31.251.173:8081/youroom/"

  class Base
    attr_accessor :url, :host, :port, :path, :header

    def initialize(url="http://youroom.in/")
      @url = url
      parse(url)
      @header = ""
    end

    def create_room(name)
      if required_structure(name, String, Symbol)
        throw_request(current_method, {:name => name.to_s} )
      else
        raise ArgumentError
      end
    end

    # user -> redmine user object
    def create_user(user)
      if required_structure(user, User)
        throw_request(current_method, {:name => user.name, :email => user.mail, :bpr => user.login})
      else
        raise ArgumentError
      end
    end

    # projct -> redmine project object
    # user -> redmine user object
    def create_participation(project, user)
      if required_structure(project, Project) and required_structure(user, User)
        throw_request(current_method, {:room_id => project.room_id.to_s, :bpr => user.login} )
      else
        raise ArgumentError
      end
    end

    def destroy_participation(project, user)
      if required_structure(project, Project) and required_structure(user, User)
        throw_request(current_method, {:room_id => project.room_id.to_s, :bpr => user.login} )
      else
        raise ArgumentError
      end
    end

    private
    def parse(url)
      uri = URI.parse(url)
      @host, @port, @path = uri.host, uri.port, uri.path
    end

    def required_structure(name, *elements)
      elements.include?(name.class)
    end

    def throw_request(method, params)
      begin
        Net::HTTP.start(@host, @port) do |http|
          http.post(request_path(method), request_params(params), @header)
        end
      rescue => e
        return e
      end
    end

    def request_path(method)
      case method
        when 'create_room'; File.join(@path, 'redmine', 'room_create')
        when 'create_user'; File.join(@path, 'redmine', 'user_create')
        when 'create_participation'; File.join(@path, 'redmine', 'participation_create')
        when 'destroy_participation'; File.join(@path, 'redmine', 'participation_destroy')
      end
    end

    def request_params(params)
      params.inject("") {|res, ary| res += ary.first.to_s + "=" + ary.last + "&" }.chop
    end
  end

  Base.class_eval do
    include OAuth
  end
end

