# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Like.delete_all
Review.delete_all
Idea.delete_all
User.delete_all


PASSWORD = "supersecret"  

super_user = User.create(
    name: "ayaka",
    email: "okusan@gmail.com",
    password: PASSWORD,
)

10.times do
    name = Faker::Name.first_name
    User.create(
    name: name, 
    email: "#{name.downcase}@example.com",
    password: PASSWORD
    )
end

users = User.all
puts "Created #{users.count} users"

100.times do
    user = users.sample
    idea = Idea.create(
        title: Faker::Hacker.say_something_smart,
        description: Faker::ChuckNorris.fact,
        created_at: Faker::Date.backward(days:365 * 5),
        updated_at: Faker::Date.backward(days:365 * 5),
        user_id: user.id
    )
    if idea.valid?
        idea.reviews = rand(0..15).times.map do
            Review.new({
                body: Faker::GreekPhilosophers.quote, 
                user_id: user.id
            })
        end
        idea.likers = users.shuffle.slice(0, rand(users.count))
    # else
    #     puts "Invalid ideas!!"
    #     p idea
    end
    
end

puts "Generated #{Idea.count} ideas"
puts "Generated #{Review.count} reviews"

