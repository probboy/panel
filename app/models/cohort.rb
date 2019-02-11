class Cohort < ApplicationRecord
  has_many :students, :through => :enrollments
  has_many :enrollments
end
