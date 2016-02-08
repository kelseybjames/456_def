class Team < ActiveRecord::Base
  belongs_to :owner, 
              class_name: 'Employee',
              foreign_key: :owner_id

  has_many :members,
            class_name: 'Employee'

  has_many :progress_reports
end
