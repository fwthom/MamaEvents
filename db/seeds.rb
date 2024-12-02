require 'faker'

Participation.destroy_all
Event.destroy_all
Charity.destroy_all
User.destroy_all

# Users
User.create!(
  email: "calpin@lewagon.org",
  password: "password",
  role: "admin"
)
User.create!(
  email: "volunteer@lewagon.org",
  password: "password",
  role: "volunteer"
)

# Charity
charity = Charity.create!(
  name: "Mes Amis Mes Amours",
  description: "Association de lutte contre le cancer du sein",
  contact_email: "contact@helpinghands.org",
  phone_number: "+1234567890"
)

# Create the 3 event YUL 2024
event_1 = Event.create!(
  name: "YUL 2024",
  description: "Passer un moment convivial de sport avec la marche ou la course, mais également de fête (musique, tombola et barbecue pour clôturer la journée).",
  date: Date.new(2025, 10, 05),
  charity: charity,
  status: "brouillon"
)

event_2 = Event.create!(
  name: "YUL 2025",
  description: "Passer un moment convivial de sport avec la marche ou la course, mais également de fête (musique, tombola et barbecue pour clôturer la journée).Passer un moment convivial de sport avec la marche ou la course, mais également de fête (musique, tombola et barbecue pour clôturer la journée).Passer un moment convivial de sport avec la marche ou la course, mais également de fête (musique, tombola et barbecue pour clôturer la journée).",
  date: Date.new(2024, 10, 05),
  charity: charity,
  status: "brouillon"

)


event_3 = Event.create!(
  name: "La MAMA 2026",
  description: "Passer un moment convivial de sport avec la marche ou la course, mais également de fête (musique, tombola et barbecue pour clôturer la journée).",
  date: Date.new(2026, 5, 5),
  charity: charity,
  status: "brouillon"

)


# Create tickets for the event (both presentiel and distanciel)
ticket1 = Ticket.create!(
  name: "Marche 5km (Présentiel)",
  description: "Une marche de 5 km en présentiel",
  unit_price: 12.0,
  event: event_1
)


# Tickets
tickets = [
  Ticket.create!(name: "Marche 5km (Présentiel)", description: "Une marche de 5 km en présentiel", unit_price: 12.0, event: event_1),
  Ticket.create!(name: "Course 5km (Présentiel)", description: "Une course de 5 km en présentiel", unit_price: 12.0, event: event_1),
  Ticket.create!(name: "Course 10km (Présentiel)", description: "Une course de 10 km en présentiel", unit_price: 15.0, event: event_1),
  Ticket.create!(name: "Dossard numérique (Distanciel)", description: "Participez à l'événement à distance et recevez un dossard numérique.", unit_price: 5.0, event: event_1)
]

# Options
options = [
  Option.create!(name: "Frites", description: "Délicieuses et croustillantes", unit_price: 4.0, category: "Alimentaire", event: event_1),
  Option.create!(name: "Hot Dog", description: "Un délicieux hot dog", unit_price: 5.0, category: "Alimentaire", event: event_1),
  Option.create!(name: "T-shirt S", description: "T-shirt taille S", unit_price: 10.0, category: "Vestimentaire", event: event_1),
  Option.create!(name: "T-shirt M", description: "T-shirt taille M", unit_price: 10.0, category: "Vestimentaire", event: event_1),
  Option.create!(name: "T-shirt L", description: "T-shirt taille L", unit_price: 10.0, category: "Vestimentaire", event: event_1)
]

# Assign options to tickets
tickets[0].options << options[0..2]
tickets[1].options << options[0..2]
tickets[2].options << options[0..2]
tickets[3].options << [options[1], options[3], options[4]]

# Participants and Participations
50.times do
  event = event_1 # Randomly assign an event
  ticket = event.tickets.sample # Randomly assign a ticket from the event

  participant = Participant.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    event_id: event.id # Ensure participant is linked to the event
  )

  Participation.create!(
    participant: participant,
    ticket: ticket,
    status: "confirmed",
    total_amount: ticket.unit_price,
    payment_id: nil # Replace this with a valid payment_id if necessary
  )
end

puts "Created #{Event.count} events, #{Ticket.count} tickets, #{Option.count} options, #{Participant.count} participants, and #{Participation.count} participations."
