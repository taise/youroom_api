require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::Entry do
  def access_token
    @access_token ||= OAuth::AccessToken.new(consumer, "hoge", "hoge")
  end

  def consumer
    @consumer ||= OAuth::Consumer.new("a", "b")
  end

  describe "#initialize" do
    describe "when mutter_id == nil" do
      subject { Youroom::Entry.new(access_token, "room_id") }
      it { should be_a(Youroom::Entry) }
      its(:url) { should == Youroom::BASE_URL }
      its(:room_id) { should == "room_id" }
      its(:mutter_id) { should == nil }
      its(:access_token) { should == access_token }
    end

    describe "when mutter_id != nil" do
      subject { Youroom::Entry.new(access_token, "room_id", "mutter_id") }
      it { should be_a(Youroom::Entry) }
      its(:url) { should == Youroom::BASE_URL }
      its(:room_id) { should == "room_id" }
      its(:mutter_id) { should == "mutter_id" }
      its(:access_token) { should == access_token }
    end

    describe "when can't create instance" do
      describe "case1: room_id is not either String or Symbol" do
        it "should raise ArgumentError" do
          lambda { Youroom::Entry.new(access_token, 100) }.should raise_exception(ArgumentError)
        end
      end

      describe "case2: mutter_id is not either String or Symbol or Integer" do
        it "should raise ArgumentError" do
          lambda { Youroom::Entry.new(access_token, "room_id", [2]) }.should raise_exception(ArgumentError)
        end
      end
    end
  end

  describe "#path" do
    describe "when mutter_id == nil" do
      before do
        @client = Youroom::Entry.new(access_token, "room_id")
      end

      subject { @client.path }
      it { should == "https://home.youroom.in/group/room_id/entries.json"}
    end

    describe "when mutter_id != nil" do
      before do
        @client = Youroom::Entry.new(access_token, "room_id", 1111)
      end

      subject { @client.path }
      it { should == "https://home.youroom.in/group/room_id/entries/1111.json"}
    end
  end
end