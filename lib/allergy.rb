class Allergy
  attr_reader :id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id'].to_i
  end

  def self.all
    allergies = []
    results = DB.exec("SELECT * FROM allergies;")
    results.each do |result|
      allergies << Allergy.new(result)
    end
    allergies
  end

  def self.find(id)
    Allergy.new(DB.exec("SELECT * FROM allergies WHERE id = #{id};").first)
  end

  def save
    @id = DB.exec("INSERT INTO allergies (name) VALUES ('#{@name}') RETURNING id;").first['id'].to_i
  end

  def ==(other_allergy)
    @name == other_allergy.name
  end

  def delete
    DB.exec("DELETE FROM allergies WHERE id = #{@id};")
  end

  def edit_name(new_name)
    DB.exec("UPDATE allergies SET name = '#{new_name}' WHERE id = #{@id};")
    @name = new_name
  end
end
