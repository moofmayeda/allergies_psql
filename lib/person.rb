class Person
  attr_reader :id
  attr_accessor :name, :preference_id

  def initialize(attributes)
    @name = attributes['name']
    @preference_id = attributes['preference_id'].to_i
    @id = attributes['id'].to_i
  end

  def self.all
    people = []
    results = DB.exec("SELECT * FROM people;")
    results.each do |result|
      people << Person.new(result)
    end
    people
  end

  def self.find(name)
    Person.new(DB.exec("SELECT * FROM people WHERE name = '#{name}';").first)
  end

  def save
    @id = DB.exec("INSERT INTO people (name, preference_id) VALUES ('#{@name}', #{@preference_id}) RETURNING id;").first['id'].to_i
  end

  def ==(other_person)
    @name == other_person.name && @preference_id == other_person.preference_id
  end

  def delete
    DB.exec("DELETE FROM people WHERE id = #{@id};")
  end

  def edit_name(new_name)
    DB.exec("UPDATE people SET name = '#{new_name}' WHERE id = #{@id};")
    @name = new_name
  end

  def edit_preference(new_pref_id)
    DB.exec("UPDATE people SET preference_id = #{new_pref_id} WHERE id = #{@id};")
    @preference_id = new_pref_id
  end

  def add_allergy(allergy_id)
    DB.exec("INSERT INTO people_allergies (person_id, allergy_id) VALUES (#{@id}, #{allergy_id});")
  end

  def allergies
    allergies = []
    results = DB.exec("SELECT allergies.* FROM people JOIN people_allergies ON (people.id = person_id) JOIN allergies ON (allergy_id = allergies.id) WHERE people.id = #{@id};")
    results.each do |result|
      allergies << Allergy.new(result)
    end
    allergies
  end
end
