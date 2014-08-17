class ChangePersonsToPeople < ActiveRecord::Migration
  def change
    rename_table :allergies_persons, :allergies_people
    rename_table :persons, :people
  end
end
