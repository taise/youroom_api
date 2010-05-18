require File.expand_path("../spec_helper", File.dirname(__FILE__))

describe Youroom::DestroyParticipation do

  describe "#call" do
    before do
      @participation = Youroom::DestroyParticipation.new("room_id", "test_pochi@gmail.com", WW_URL)
      WW::Server.mock(:youroom, :room_id => "room_id", :email => "test_pochi@gmail.com").
                 post("/youroom/redmine/participation/destroy") do
        { :status => "Created" }.to_json
      end
    end

    after do
      WW::Server.verify(:youroom)
    end

    subject { @participation.call }
    it "should call request url" do
      should be_an_instance_of(Net::HTTPOK)
    end
  end

  describe "#path" do
    before do
      @participation = Youroom::DestroyParticipation.new("room_id", "test_pochi@gmail.com", WW_URL)
    end
    subject { @participation.path }
    it { should == "/youroom/redmine/participation/destroy" }
  end

end
