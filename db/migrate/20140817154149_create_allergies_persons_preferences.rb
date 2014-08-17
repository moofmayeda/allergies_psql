class CreateAllergiesPersonsPreferences < ActiveRecord::Migration
  def change
    create_table :allergies do |t|
      t.string :name
      t.timestamps
    end

    create_table :persons do |t|
      t.string :name
      t.belongs_to :preference
      t.timestamps
    end

    create_table :allergies_persons do |t|
      t.belongs_to :allergy
      t.belongs_to :person
      t.timestamps
    end

    create_table :preferences do |t|
      t.string :name
      t.timestamps
    end
  end
end
