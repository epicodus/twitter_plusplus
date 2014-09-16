require 'rails_helper'


describe Tweet do
  it { should validate_presence_of :content }
  it { should ensure_length_of(:content).is_at_least(1) }
  it { should ensure_length_of(:content).is_at_most(141) }

  describe "mentions" do
    it "returns an empty array if handles do not exist as users" do
      tweet = Tweet.new(content: "hello @test looking for @handles")
      expect(tweet.find_mentions).to eq []
    end

    it "returns an array of users if their handle is mentioned" do
      user = FactoryGirl.create(:user)

      mentioned_user1 = FactoryGirl.create(:user)
      mentioned_user2 = FactoryGirl.create(:user)

      user.tweets << Tweet.new(content: "hi @#{mentioned_user1.handle} and @#{mentioned_user2.handle} but not @notexist!")
      expect(user.tweets[-1].find_mentions).to eq [mentioned_user1, mentioned_user2]
      expect(mentioned_user1.mentions.length).to eq 1
      expect(mentioned_user2.mentions.length).to eq 1
    end

    it "only writes one entry to the mentions database if a user's handle is mentioned > 1 times ina  tweet" do
      user = FactoryGirl.create(:user)
      user2 = FactoryGirl.create(:user)

      user.tweets << Tweet.new(content: "hi @#{user2.handle}, don't write these mentions @#{user2.handle} @#{user2.handle} @#{user2.handle} ")
      user.tweets[-1].find_mentions
      expect(user2.mentions.length).to eq 1
    end
  end
end
