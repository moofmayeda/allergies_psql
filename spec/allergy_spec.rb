require 'spec_helper'

describe "Allergy" do
  describe "initialize" do
    it "initializes an allergy with a name" do
      test_allergy = Allergy.new({'name' => 'peanuts'})
      expect(test_allergy).to be_a Allergy
    end
  end

  describe "save" do
    it "saves an allergy to the database" do
      test_allergy = Allergy.new({'name' => 'peanuts'})
      test_allergy.save
      expect(Allergy.all).to eq [test_allergy]
    end
  end

  describe ".all" do
    it "returns all allergys in an array" do
      test_allergy = Allergy.new({'name' => 'peanuts'})
      test_allergy.save
      test_allergy2 = Allergy.new({'name' => 'strawberries'})
      test_allergy2.save
      expect(Allergy.all).to eq [test_allergy, test_allergy2]
    end
  end

  describe "==" do
    it "sets two allergys as equal if their names are equal" do
      test_allergy = Allergy.new({'name' => 'peanuts'})
      test_allergy.save
      test_allergy2 = Allergy.new({'name' => 'peanuts'})
      test_allergy2.save
      expect(test_allergy).to eq test_allergy2
    end
  end

  describe "delete" do
    it "deletes an allergy from the database" do
      test_allergy = Allergy.new({'name' => 'peanuts'})
      test_allergy.save
      test_allergy.delete
      expect(Allergy.all).to eq []
    end
  end

  describe "edit_name" do
    it "edits an allergy's name in the database" do
      test_allergy = Allergy.new({'name' => 'peanuts'})
      test_allergy.save
      test_allergy.edit_name("peanut")
      expect(test_allergy.name).to eq "peanut"
    end
  end

  describe ".find" do
    it "finds an allergy given its id" do
      test_allergy = Allergy.new({'name' => 'peanuts'})
      test_allergy.save
      id = test_allergy.id
      expect(Allergy.find(id)).to eq test_allergy
    end
  end
end
