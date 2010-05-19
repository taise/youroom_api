module Youroom

  class OAuth < Base
    attr_accessor :request

    def initialize(access_token, url=BASE_URL)
      @request = Request.new(access_token, url)
    end

    def create_room(name)
      @request = CreateRoom.new(name, url)
      request.call
    end

    def create_user(name, email, bpr=nil)
      @request = CreateUser.new(name, email, bpr, url)
      request.call
    end

    def create_participation(room_id, email)
      @request = CreateParticipation.new(room_id, email, url)
      request.call
    end

    def destroy_participation(room_id, email)
      @request = DestroyParticipation.new(room_id, email, url)
      request.call
    end

    def entries(room_id)
      request.get_entries(room_id)
    end
  end

end


