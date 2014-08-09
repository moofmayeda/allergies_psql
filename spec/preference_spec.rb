require 'spec_helper'

describe "Preference" do
  describe "initialize" do
    it "initializes a preference with a name" do
      test_preference = Preference.new({'name' => 'vegetarian'})
      expect(test_preference).to be_a Preference
    end
  end

  describe "save" do
    it "saves a preference to the database" do
      test_preference = Preference.new({'name' => 'vegetarian'})
      test_preference.save
      expect(Preference.all).to eq [test_preference]
    end
  end

  describe ".all" do
    it "returns all preferences in an array" do
      test_preference = Preference.new({'name' => 'vegetarian'})
      test_preference.save
      test_preference2 = Preference.new({'name' => 'none'})
      test_preference2.save
      expect(Preference.all).to eq [test_preference, test_preference2]
    end
  end

  describe "==" do
    it "sets two preferences as equal if their names are equal" do
      test_preference = Preference.new({'name' => 'vegetarian'})
      test_preference.save
      test_preference2 = Preference.new({'name' => 'vegetarian'})
      test_preference2.save
      expect(test_preference).to eq test_preference2
    end
  end

  describe "delete" do
    it "deletes a preference from the database" do
      test_preference = Preference.new({'name' => 'vegetarian'})
      test_preference.save
      test_preference.delete
      expect(Preference.all).to eq []
    end
  end

  describe "edit_name" do
    it "edits a preference's name in the database" do
      test_preference = Preference.new({'name' => 'vegetarian'})
      test_preference.save
      test_preference.edit_name("vegan")
      expect(test_preference.name).to eq "vegan"
    end
  end

  describe ".find" do
    it "finds a preference given its id" do
      test_preference = Preference.new({'name' => 'vegetarian'})
      test_preference.save
      id = test_preference.id
      expect(Preference.find(id)).to eq test_preference
    end
  end
end
