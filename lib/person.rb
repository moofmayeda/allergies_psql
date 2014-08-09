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

  def save
    @id = DB.exec("INSERT INTO people (name, preference_id) VALUES ('#{@name}', #{@preference_id}) RETURNING id;").first['id'].to_i
  end

  def ==(other_person)
    @name == other_person.name && @preference_id == other_person.preference_id
  end
end
