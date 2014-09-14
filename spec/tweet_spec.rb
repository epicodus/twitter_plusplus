require 'rails_helper'


describe Tweet do
    it { should validate_presence_of :content }
    it { should ensure_length_of(:content).is_at_least(1) }
    it { should ensure_length_of(:content).is_at_most(141) }
end
