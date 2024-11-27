# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
Ticket.destroy_all
Event.destroy_all
Charity.destroy_all


User.create!(
  email: "calpin@lewagon.org",
  password: "password" 
)

Charity.create!(
  name: "Mes Amis Mes Amours",
  description: "An organization dedicated to providing aid to those in need.",
  contact_email: "contact@helpinghands.org",
  phone_number: "+1234567890",
  # user_id: User.first.id
)

Event.create!(
  name: "MAMA 2025",
  description: "Passer un moment convivial de sport avec la marche ou la course, mais également de fête (musique, tombola et barbecue pour clôturer la journée).",
  date: Date.new(2025, 10, 20),
  charity_id: Charity.first.id

)

Event.create!(
  name: "YUL 2024",
  description: "Passer un moment convivial de sport avec la marche ou la course, mais également de fête (musique, tombola et barbecue pour clôturer la journée).",
  date: Date.new(2024, 10, 05),
  charity_id: Charity.first.id
)

puts "------- creating Tickets ------------------"
    Ticket.create!(
      name: "Course 10km",
      description: "Une course de 10 km",
      unit_price: 12.0,
      event_id:Event.last.id
    )
    Ticket.create!(
      name: "Course 5km",
      description: "Une course de 5 km",
      unit_price: 12.0,
      event_id:Event.last.id
    )
    Ticket.create!(
      name: "Course 10km",
      description: "Une course de 10 km",
      unit_price: 12.0,
      event_id:Event.first.id
    )
    Ticket.create!(
      name: "Course 5km",
      description: "Une course de 5 km",
      unit_price: 12.0,
      event_id:Event.first.id
    )
puts "-------#{Ticket.count} Tickets --------"

