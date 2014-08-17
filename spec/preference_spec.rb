require 'spec_helper'

describe Preference do
  it { should have_many :people }
  # describe "count" do
  #   it "counts the number of people with that preference" do
  #     test_preference = Preference.new({'name' => 'vegetarian'})
  #     test_preference.save
  #     preference_id = test_preference.id
  #     test_person = Person.new({'name' => 'moof', 'preference_id' => preference_id})
  #     test_person.save
  #     test_person2 = Person.new({'name' => 'ali', 'preference_id' => preference_id})
  #     test_person2.save
  #     expect(test_preference.count).to eq 2
  #   end
  # end
end
