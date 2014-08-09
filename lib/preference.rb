class Preference
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def self.all
    preferences = []
    results = DB.exec("SELECT * FROM preferences;")
    results.each do |result|
      preferences << Preference.new(result)
    end
    preferences
  end

  def self.find(id)
    Preference.new(DB.exec("SELECT * FROM preferences WHERE id = #{id};").first)
  end

  def save
    @id = DB.exec("INSERT INTO preferences (name) VALUES ('#{@name}') RETURNING id;").first['id'].to_i
  end

  def ==(other_preference)
    @name == other_preference.name
  end

  def delete
    DB.exec("DELETE FROM preferences WHERE id = #{@id};")
  end

  def edit_name(new_name)
    DB.exec("UPDATE preferences SET name = '#{new_name}' WHERE id = #{@id};")
    @name = new_name
  end

  def allergies
    allergies = []
    results = DB.exec("SELECT allergies.* FROM people JOIN people_allergies ON (people.id = person_id) JOIN allergies ON (allergy_id = allergies.id) WHERE people.preference_id = #{@id};")
    results.each do |result|
      allergies << Allergy.new(result)
    end
    allergies
  end
end
