# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.new(
  :email                 => ENV["ADMIN1_MAIL"],
  :password              => ENV["ADMIN1_PASSWORD"],
  :password_confirmation => ENV["ADMIN1_PASSWORD"],
  :admin                 => true
)
user.skip_confirmation!
user.save!

user = User.new(
  :email                 => ENV["ADMIN2_MAIL"],
  :password              => ENV["ADMIN1_PASSWORD"],
  :password_confirmation => ENV["ADMIN1_PASSWORD"],
  :admin                 => true
)
user.skip_confirmation!
user.save!

plan = Plan.create(
  :name       => "1 Month Plan",
  :interval   => "month",
  :duration   => 1,
  :currency   => "USD",
  :price      => 60
)

plan = Plan.create(
  :name       => "3 Month Plan",
  :interval   => "month",
  :duration   => 3,
  :currency   => "USD",
  :price      => 340
)

plan = Plan.create(
  :name       => "6 Month Plan",
  :interval   => "month",
  :duration   => 6,
  :currency   => "USD",
  :price      => 680
)