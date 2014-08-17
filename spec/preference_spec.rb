require 'spec_helper'

describe Preference do
  it { should have_many :people }

  it { should validate_presence_of :name }

  it { should validate_uniqueness_of :name }

  it 'converts the name to uppercase' do
    preference = Preference.create(:name => "vegetarian")
    expect(preference.name).to eq "VEGETARIAN"
  end
end
