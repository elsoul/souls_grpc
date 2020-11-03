# Initial Data need to be saved in DB.
# rails db:seed RAILS_ENV=development

puts "created user" if User.create(
  id: "xxxxxxx",
  username: "POPPIN-FUMI",
  screen_name: "ELSOUL",
  email: "info@xxx.com"
)
