require 'spec_helper'

describe "Person" do
  describe "initialize" do
    it "initializes a person with a name and preference id" do
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      expect(test_person).to be_a Person
    end
  end

  describe "save" do
    it "saves a person to the database" do
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person.save
      expect(Person.all).to eq [test_person]
    end
  end

  describe ".all" do
    it "returns all people in an array" do
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person.save
      test_person2 = Person.new({'name' => 'ali', 'preference_id' => 1})
      test_person2.save
      expect(Person.all).to eq [test_person, test_person2]
    end
  end

  describe "==" do
    it "sets two people as equal if their names and preference ids are equal" do
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person.save
      test_person2 = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person2.save
      expect(test_person).to eq test_person2
    end
  end
end
