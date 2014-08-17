class Person < ActiveRecord::Base
  has_and_belongs_to_many :allergies
  belongs_to :preference

  validates :name, :presence => true

  scope :rsvp, -> { where(rsvp: true) }

  before_save :upcase_name

private

  def upcase_name
    self.name = self.name.upcase
  end
end
