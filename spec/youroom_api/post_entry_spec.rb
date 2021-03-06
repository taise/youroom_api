# encoding: utf-8
require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::PostEntry do
  describe "#initialize" do
    describe "when can create instance" do
      subject { Youroom::PostEntry.new(access_token, "room_id", "hogehoge", nil) }
      it { should be_a(Youroom::PostEntry) }
      its(:url) { should == Youroom::BASE_URL }
      its(:room_id) { should == "room_id" }
      its(:content) { should == "hogehoge" }
      its(:access_token) { should == access_token }
    end

    describe "room_idにFixunumオブジェクトが引数になった場合" do
      it "例外が発生しないこと" do
        lambda { Youroom::PostEntry.new(access_token, 100, "test") }.should_not raise_exception
      end
    end

    describe "contentにFixunumオブジェクトが引数になった場合" do
      it "例外が発生しないこと" do
        lambda { Youroom::PostEntry.new(access_token, 100, 1000) }.should_not raise_exception
      end
    end
  end

  describe "#path" do
    describe "when url is original" do
      before do
        @client = Youroom::PostEntry.new(access_token, "room_id", "hogehoge", nil)
      end

      subject { @client.path }
      it { should == File.join(@client.url, 'r', 'room_id', 'entries?format=json') }
    end

    describe "when url is not original" do
      before do
        @client = Youroom::PostEntry.new(access_token, "room_id", "hogehoge", WW_URL)
      end

      subject { @client.path }
      it { should == File.join(@client.url, 'r', 'room_id', 'entries?format=json') }
    end
  end

  describe "#post" do
    before do
      @client = Youroom::PostEntry.new(access_token, "room_id", "hogehoge", nil, WW_URL)
      WW::Server.mock(:youroom).post("/youroom/r/room_id/entries") do
        { :status => "Created" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @client.post }
    it "should call request url" do
      should be_a_instance_of(Hash)
    end
  end

  describe "#params" do
    before do
      @client = Youroom::PostEntry.new(access_token, "room_id", "hogehoge", nil, WW_URL)
    end

    subject { @client.params }
    it { should == { 'entry[content]' => 'hogehoge', 'insert_mention' => '' } }
  end

end
