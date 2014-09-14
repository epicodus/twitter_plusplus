
require 'rails_helper'

describe Relation do

  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }

  let(:relation) { follower.relations.build(followed_id: followed.id) }

  subject { relation }
  it { should be_valid }


  describe "following" do
    it { should respond_to :follower }
    it { should respond_to :followed }

    its(:follower) { should eq follower }
    its(:followed) { should eq followed }
  end

  describe "it should not create a relation without a follower id" do
    before { relation.follower_id = nil }
    it { should_not be_valid }
  end

  describe "does not create a valid relation without a followed by id" do
      before { relation.followed_id = nil }
      it { should_not be_valid }
  end

end
