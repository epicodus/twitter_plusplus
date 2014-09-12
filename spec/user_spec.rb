require 'rails_helper'

describe User do
  it { should validate_presence_of (:handle) }
  it { should validate_uniqueness_of(:handle) }
  it { should ensure_length_of(:handle).is_at_least(4) }
  it { should ensure_length_of(:handle).is_at_most(12) }
  it { should allow_value('justin', 'speers', 'justin_sp', 'justin82', '82_justinsp').for(:handle) }
  it { should_not allow_value('justin@sp', '82-justinsp', '@#$@#%', 'j u s tin', '@justin').for(:handle) }

  
end
