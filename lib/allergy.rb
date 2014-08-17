class Allergy < ActiveRecord::Base
  has_and_belongs_to_many :people

  validates :name, :presence => true, :uniqueness => true

  before_save :upcase_name

private

  def upcase_name
    self.name = self.name.upcase
  end
end
