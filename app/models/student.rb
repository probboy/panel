class Student < ApplicationRecord
  has_many :cohorts, :through => :enrollments
  has_many :enrollments
end
