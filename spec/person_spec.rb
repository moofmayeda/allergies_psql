require 'spec_helper'

describe Person do
  it { should have_and_belong_to_many :allergies }

  it { should belong_to :preference }

  it { should validate_presence_of :name }

  it 'converts the name to uppercase' do
    person = Person.create(:name => "joe")
    expect(person.name).to eq "JOE"
  end
end
