
User.destroy_all
Option.destroy_all
Ticket.destroy_all
Event.destroy_all
Charity.destroy_all

User.create!(
  email: "calpin@lewagon.org",
  password: "password"
)

# Create a charity
charity = Charity.create!(
  name: "Mes Amis Mes Amours",
  description: "An organization dedicated to providing aid to those in need.",
  contact_email: "contact@helpinghands.org",
  phone_number: "+1234567890"
)

# Create the single event YUL 2024
event = Event.create!(
  name: "YUL 2024",
  description: "Passer un moment convivial de sport avec la marche ou la course, mais également de fête (musique, tombola et barbecue pour clôturer la journée).",
  date: Date.new(2024, 10, 05),
  charity_id: charity.id
)


# Create tickets for the event (both presentiel and distanciel)
ticket1 = Ticket.create!(
  name: "Marche 5km (Présentiel)",
  description: "Une marche de 5 km en présentiel",
  unit_price: 12.0,
  event_id: event.id
)

ticket2 = Ticket.create!(
  name: "Course 5km (Présentiel)",
  description: "Une course de 5 km en présentiel",
  unit_price: 12.0,
  event_id: event.id
)

ticket3 = Ticket.create!(
  name: "Course 10km (Présentiel)",
  description: "Une course de 10 km en présentiel",
  unit_price: 15.0,
  event_id: event.id
)

ticket4 = Ticket.create!(
  name: "Dossard numérique (Distanciel)",
  description: "Participez à l'événement à distance et recevez un dossard numérique.",
  unit_price: 5.0,
  event_id: event.id
)

# Create options (alimentaire et vestimentaire)
option1 = Option.create!(
  name: "Frites",
  description: "Délicieuses et croustillantes",
  unit_price: 4.0,
  category: "Alimentaire"
)

option2 = Option.create!(
  name: "Hot Dog",
  description: "Un délicieux hot dog",
  unit_price: 5.0,
  category: "Alimentaire"
)

option3 = Option.create!(
  name: "T-shirt S",
  description: "T-shirt taille S",
  unit_price: 10.0,
  category: "Vestimentaire"
)

option4 = Option.create!(
  name: "T-shirt M",
  description: "T-shirt taille M",
  unit_price: 10.0,
  category: "Vestimentaire"
)

option5 = Option.create!(
  name: "T-shirt L",
  description: "T-shirt taille L",
  unit_price: 10.0,
  category: "Vestimentaire"
)

# Assign options to tickets
ticket1.options << option1
ticket1.options << option3
ticket1.options << option4

ticket2.options << option1
ticket2.options << option3
ticket2.options << option4

ticket3.options << option1
ticket3.options << option3
ticket3.options << option4

ticket4.options << option2
ticket4.options << option3
ticket4.options << option5

puts "Created #{Ticket.count} tickets, #{Option.count} options, and #{Event.count} events."