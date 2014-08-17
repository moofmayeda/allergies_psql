class Allergy < ActiveRecord::Base
  has_and_belongs_to_many :people

  # def count
  #   DB.exec("SELECT COUNT(id) FROM people_allergies WHERE allergy_id = #{@id};").first['count'].to_i
  # end
end
