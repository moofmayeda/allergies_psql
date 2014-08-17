class Person < ActiveRecord::Base
  has_and_belongs_to_many :allergies
  belongs_to :preference
end
