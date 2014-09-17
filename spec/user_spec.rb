require 'rails_helper'

describe User do
  it { should validate_presence_of (:handle) }
  it { should validate_uniqueness_of(:handle) }
  it { should ensure_length_of(:handle).is_at_least(4) }
  it { should ensure_length_of(:handle).is_at_most(12) }
  it { should allow_value('justin', 'speers', 'justin_sp', 'justin82', '82_justinsp').for(:handle) }
  it { should_not allow_value('justin@sp', '82-justinsp', '@#$@#%', 'j u s tin', '@justin').for(:handle) }
  it { should ensure_length_of(:bio).is_at_most(141) }

  it { should respond_to :relations }
  it { should respond_to :followed_users }
  it { should respond_to :follow! }
  it { should respond_to :following? }
  it { should respond_to :followers }
  it { should respond_to :reverse_relations }

  describe "following" do
    describe "following?" do
      it "should return false when asked if a user follows someone they don't" do
        expect(FactoryGirl.create(:user).following?(FactoryGirl.create(:user))).to be_nil
      end

      it "should return true when a user is following the other user in question" do
        @user_followed = FactoryGirl.create(:user)
        @user_follower = FactoryGirl.create(:user)
        @user_follower.follow!(@user_followed)
        expect(@user_follower.following?(@user_followed)).to be_truthy
      end

    end

    describe "unfollowing" do
      it "should remove a follower" do
        @user = FactoryGirl.create(:user)
        @boring_user = FactoryGirl.create(:user)

        @user.follow!(@boring_user)
        expect(@user.following?(@boring_user)).to be_truthy
        @user.unfollow!(@boring_user)
        expect(@user.following?(@boring_user)).to be_nil
      end
    end

    describe "followers" do
      it "should return an empty array when a user has no followers" do
        expect(FactoryGirl.create(:user).followers).to eq []
      end

      it "should return any followers a user has" do
        @lady_gaga = FactoryGirl.create(:user)
        @fan = FactoryGirl.create(:user)

        @fan.follow!(@lady_gaga)
        expect(@lady_gaga.followers).to eq [@fan]
      end
    end
  end

  describe "any_tweets?" do
    it "returns false if the user has no tweets to view" do
      expect(FactoryGirl.create(:user).any_tweets?).to eq false
    end

    it "returns true if the user or anyone they follow has ever tweeted" do
      user = FactoryGirl.create(:user)
      user.tweets << FactoryGirl.create(:tweet)
      expect(user.any_tweets?).to eq true
    end
  end

  describe "all_tweets" do
    it "returns all tweets by a user and those they follow" do
      @follower = FactoryGirl.create(:user)
      @followed = FactoryGirl.create(:user)
      @follower.follow!(@followed)

      3.times { @followed.tweets << FactoryGirl.create(:tweet) }
      3.times { @follower.tweets << FactoryGirl.create(:tweet) }

      expect(@follower.all_tweets.length).to eq 6
    end
  end

  describe "all_tweets_timeline" do
    it "returns all tweets by a user and those they follow, sorted by date/time" do
      @person = FactoryGirl.create(:user)
      @other_person = FactoryGirl.create(:user)
      @person.follow!(@other_person)

      ordered_tweets = []
      4.times do
        ordered_tweets << FactoryGirl.create(:tweet)
        sleep 1
      end

      @person.tweets << ordered_tweets[0]
      @person.tweets << ordered_tweets[2]
      @other_person.tweets << ordered_tweets[1]
      @other_person.tweets << ordered_tweets[3]

      expect(@person.all_tweets_timeline).to eq ordered_tweets.reverse
    end
  end

  describe "mentioned?" do
    it "returns false if a tweet does not mention a user" do
      tweet = FactoryGirl.create(:tweet)
      user = FactoryGirl.create(:user)

      expect(user.mentioned?(tweet)).to eq false
    end

    it "returns true if a tweet mentions a user" do
      user = FactoryGirl.create(:user)
      tweet = Tweet.create(content: "Hello, @#{user.handle}!")
      tweet.find_mentions
      expect(user.mentioned?(tweet)).to eq true
    end
  end
end
