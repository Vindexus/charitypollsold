# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.count == 0
  User.create({email: 'vindexus@gmail.com', password: "testtest", password_confirmation: "testtest", admin: true})
end

if Charity.count == 0
	Charity.create({name: "charity:water", website: "http://charitywater.org"})
	Charity.create({name: "Doctos Without Borders", website: "http://www.doctorswithoutborders.org"})
	Charity.create({name: "American Red Cross", website: "http://redcross.org"})
end