class AddRsvp < ActiveRecord::Migration
  def change
    add_column :people, :rsvp, :boolean, :default => false
  end
end
