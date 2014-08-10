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

  describe "delete" do
    it "deletes a person from the database" do
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person.save
      test_person.delete
      expect(Person.all).to eq []
    end
  end

  describe "edit_name" do
    it "edits a person's name in the database" do
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person.save
      test_person.edit_name("moofin")
      expect(test_person.name).to eq "moofin"
    end
  end

  describe "edit_preference" do
    it "edits a person's preference in the database" do
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person.save
      test_person.edit_preference(1)
      expect(test_person.preference_id).to eq 1
    end
  end

  describe ".find" do
    it "finds a person given their unique name" do
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person.save
      expect(Person.find('moof')).to eq test_person
    end
  end

  describe "add_allergy" do
    it "adds an allergy to a person given the allergy id" do
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person.save
      test_allergy = Allergy.new({'name' => 'peanuts'})
      test_allergy.save
      id = test_allergy.id
      test_person.add_allergy(id)
      expect(test_person.allergies).to eq [test_allergy]
    end
  end

  describe "remove_allergy" do
    it "removes an allergy from a person given the allergy id" do
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person.save
      test_allergy = Allergy.new({'name' => 'peanuts'})
      test_allergy.save
      id = test_allergy.id
      test_person.add_allergy(id)
      test_person.remove_allergy(id)
      expect(test_person.allergies).to eq []
    end
  end

  describe "allergies" do
    it "lists all allergies that a person has" do
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person.save
      test_allergy = Allergy.new({'name' => 'peanuts'})
      test_allergy.save
      id = test_allergy.id
      test_person.add_allergy(id)
      expect(test_person.allergies).to eq [test_allergy]
    end
  end

  describe "preference" do
    it "returns the person's preference" do
      test_preference = Preference.new({'name' => 'vegetarian'})
      test_preference.save
      preference_id = test_preference.id
      test_person = Person.new({'name' => 'moof', 'preference_id' => preference_id})
      test_person.save
      expect(test_person.preference).to eq 'vegetarian'
    end
  end

  describe "search_by_preference" do
    it "returns all guests with a particular preference given an ID" do
      test_preference = Preference.new({'name' => 'vegetarian'})
      test_preference.save
      preference_id = test_preference.id
      test_person = Person.new({'name' => 'moof', 'preference_id' => preference_id})
      test_person.save
      expect(Person.search_by_preference(preference_id)).to eq [test_person]
    end
  end

  describe "search_by_allergy" do
    it "returns all guests with a particular allergy given an ID" do
      test_allergy = Allergy.new({'name' => 'peanuts'})
      test_allergy.save
      allergy_id = test_allergy.id
      test_person = Person.new({'name' => 'moof', 'preference_id' => 2})
      test_person.save
      test_person.add_allergy(allergy_id)
      expect(Person.search_by_allergy(allergy_id)).to eq [test_person]
    end
  end
end
