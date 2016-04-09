# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def random_words(count=4)
  Forgery('lorem_ipsum').lorem_ipsum_words.sample(count).join(' ')
end

main_user = User.create!(username: 'amrn', password: '123123', password_confirmation: '123123')

30.times do
  User.create!(
    username: Forgery('name').first_name + Random.rand(1000).to_s,
    password: '123123',
    password_confirmation: '123123'
  )
end

10.times do
  Chatroom.create!(
    name: random_words,
    description: random_words(10)
  )
end

main_user.subscriptions << Chatroom.all.sample(10)
