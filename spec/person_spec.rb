require 'spec_helper'

describe Person do
  it { should have_and_belong_to_many :allergies }

  it { should belong_to :preference }

  it { should validate_presence_of :name }

  it 'converts the name to uppercase' do
    person = Person.create(:name => "joe")
    expect(person.name).to eq "JOE"
  end

  describe "rsvp" do
    it "returns only those people who have rsvp'd" do
      test_person_1 = Person.create(name: "moof", preference_id: 1)
      test_person_2 = Person.create(name: "ali", preference_id: 2)
      test_person_1.update(rsvp: true)
      expect(Person.rsvp).to eq [test_person_1]
    end
  end
end
