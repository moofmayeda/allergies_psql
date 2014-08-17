require 'spec_helper'

describe Allergy do
  it { should have_and_belong_to_many :people }

  it { should validate_presence_of :name }

  it { should validate_uniqueness_of :name }

  it 'converts the name to uppercase' do
    allergy = Allergy.create(:name => "peanuts")
    expect(allergy.name).to eq "PEANUTS"
  end
end
