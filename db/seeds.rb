# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
MULTIPLIER = 2

def generate_employee
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email

  e = Employee.new
  e.first_name = first_name
  e.last_name = last_name
  e.email = email
  e.save!
end

def generate_team
  team_name = Faker::App.name
  owner_id = Employee.pluck(:id).sample

  t = Team.new
  t[:name] = team_name
  t[:owner_id] = owner_id
  t[:members] = []

  3.times do
    t[:members] += Employee.pluck(:id).sample
  end

  t.save!
end

def generate_progress_report
  body = Faker::Lorem.paragraph
  author_id = Employee.pluck(:id).sample
  team_id = Team.pluck(:id).sample

  p = ProgressReport.new
  p[:body] = body
  p[:author_id] = author_id
  p[:team_id] = team_id

  p.save!
end

puts 'Destroying old records'

Employee.destroy_all
Team.destroy_all
ProgressReport.destroy_all

puts 'Creating employees'

(10 * MULTIPLIER).times do
  generate_employee
end

puts 'Creating teams'

(3 * MULTIPLIER).times do
  generate_team
end

puts 'Creating progress reports'

(5 * MULTIPLIER).times do
  generate_progress_report
end

puts 'Done!'