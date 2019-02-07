# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create_with(
  :email                 => ENV["ADMIN1_MAIL"],
  :password              => ENV["ADMIN1_PASSWORD"],
  :password_confirmation => ENV["ADMIN1_PASSWORD"],
  :admin                 => true
).find_or_create_by(email: ENV["ADMIN1_MAIL"])

user = User.create_with(
  :email                 => ENV["ADMIN2_MAIL"],
  :password              => ENV["ADMIN1_PASSWORD"],
  :password_confirmation => ENV["ADMIN1_PASSWORD"],
  :admin                 => true
).find_or_create_by(email: ENV["ADMIN2_MAIL"])

p = Plan.find_or_create_by(id: 1)
p.update_attributes(
  :name       => "1 Month Plan",
  :interval   => "month",
  :duration   => 1,
  :currency   => "USD",
  :price      => 60
)


p = Plan.find_or_create_by(id: 2)
p.update_attributes(
  :name       => "3 Month Plan",
  :interval   => "month",
  :duration   => 3,
  :currency   => "USD",
  :price      => 140
)

p = Plan.find_or_create_by(id: 3)
p.update_attributes(
  :name       => "6 Month Plan",
  :interval   => "month",
  :duration   => 6,
  :currency   => "USD",
  :price      => 320
)