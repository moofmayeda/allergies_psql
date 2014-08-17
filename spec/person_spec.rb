require 'spec_helper'

describe Person do
  it { should have_and_belong_to_many :allergies }
  it { should belong_to :preference }
end
