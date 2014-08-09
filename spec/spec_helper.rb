require 'pg'
require 'rspec'
require 'person'
require 'allergy'
require 'preference'

DB = PG.connect({:dbname => 'allergies_test'})

RSpec.configure do |config|
  config.before(:each) do
    DB.exec("DELETE FROM people *;")
    DB.exec("DELETE FROM allergies *;")
    DB.exec("DELETE FROM preferences *;")
    DB.exec("DELETE FROM people_allergies *;")
  end
end
