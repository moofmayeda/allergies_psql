class Preference < ActiveRecord::Base
  has_many :people

  # def count
  #   DB.exec("SELECT COUNT(id) FROM people WHERE preference_id = #{@id};").first['count'].to_i
  # end
end
