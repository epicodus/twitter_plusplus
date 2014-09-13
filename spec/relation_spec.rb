
require 'rails_helper'

describe Relation do

  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }

  let(:relation) { follower.relations.build(followed_id: followed.id) }

  subject { relation }

  it { should be_valid }


end
