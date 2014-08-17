class Preference < ActiveRecord::Base
  has_many :people
  has_many :allergies, :through => :people

  validates :name, :presence => true, :uniqueness => true

  before_save :upcase_name

private

  def upcase_name
    self.name = self.name.upcase
  end
end
