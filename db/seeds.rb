users_in_seed = 5
# does not include hard-code admin user added
debates_in_seed = 10

if User.count < users_in_seed
  (users_in_seed - User.count).times do
    FactoryGirl.create(:user)
  end
end

#create my admin account
User.create!(
  email: "reuvenschmidt@gmail.com",
  password: "password123",
)

users = User.all
puts "#{User.count} users created"
####

if Debate.count < debates_in_seed
  (debates_in_seed - Debate.count).times do
    FactoryGirl.create(:debate)
  end
end

puts "#{Debate.count} debates created"
