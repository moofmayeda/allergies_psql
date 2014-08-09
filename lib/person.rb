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
end
