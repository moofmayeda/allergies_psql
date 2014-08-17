require 'spec_helper'

describe Allergy do
  it { should have_and_belong_to_many :people }
  # describe "count" do
  #   it "counts the number of people with that allergy" do
  #     test_allergy = Allergy.new({'name' => 'peanuts'})
  #     test_allergy.save
  #     allergy_id = test_allergy.id
  #     test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
  #     test_person.save
  #     test_person2 = Person.new({'name' => 'ali', 'preference_id' => 3})
  #     test_person2.save
  #     test_person.add_allergy(allergy_id)
  #     test_person2.add_allergy(allergy_id)
  #     expect(test_allergy.count).to eq 2
  #   end
  # end
end
