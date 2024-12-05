require 'faker'

Order.destroy_all
Participation.destroy_all
Event.destroy_all
Charity.destroy_all
User.destroy_all

# Users
User.create!(
  email: "calpin@lewagon.org",
  password: "password",
  role: "admin",
  first_name: "Jo"
)
User.create!(
  email: "volunteer@lewagon.org",
  password: "password",
  role: "volunteer",
  first_name: "Camille"
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
  name: "YUL 2025",
  description: "La 7ème édition de la YUL 2025 regroupe les amateurs de sport pour une marche dynamique et une course non chronométrée. Pour la première fois, un parcours 25km est proposé. Il sera possible de nous rejoindre à distance pour une course en distanciel.",
  date: Date.new(2025, 10, 05),
  charity: charity,
  status: "publié",
  location: "Premesques"
)


Event.create!(
  name: "La MAMA 2026",
  description: "Passer un moment convivial de sport entre mère et fille avec la mama 2025.",
  date: Date.new(2025, 05, 05),
  charity: charity,
  status: "brouillon",
  location: "Lille"
)


# Create tickets for the event (both presentiel and distanciel)
Ticket.create!(
  name: "Marche 5km",
  description: "Une marche dynamique sur 5 km. Bonne humeur assurée !",
  unit_price: 12.0,
  event: event_1
)

Ticket.create!(
  name: "Course 10km",
  description: "Une petite course non chronométrée le long de la Deûle",
  unit_price: 12.0,
  event: event_1
)

Ticket.create!(
  name: "Course 25km",
  description: "Course non chronométrée le long de la Deûle",
  unit_price: 12.0,
  event: event_1
)

Ticket.create!(
  name: "Course 10km (distanciel)",
  description: "Une petite course non chronométrée, à faire chez soi !",
  unit_price: 7.0,
  event: event_1
)

tickets = Ticket.all

# Options
options = [
  Option.create!(name: "Frites", description: "Délicieuses et croustillantes, à la graisse de bœuf", emoji: "🍟", unit_price: 3.0, category: "Alimentaire", event: event_1),
  Option.create!(name: "Bière", description: "Bien fraîche et réconfortante après l'effort", unit_price: 5.0, category: "Alimentaire", emoji: "🍻", event: event_1),
  Option.create!(name: "Hot Dog", description: "Un délicieux hot dog", unit_price: 5.0, category: "Alimentaire", emoji: "🌭", event: event_1),
  Option.create!(name: "T-shirt S", description: "T-shirt taille S floqué YUL 2025", unit_price: 10.0, category: "Vestimentaire", event: event_1, emoji: "🎽"),
  Option.create!(name: "T-shirt M", description: "T-shirt taille M floqué YUL 2025", unit_price: 10.0, category: "Vestimentaire", event: event_1, emoji: "🎽"),
  Option.create!(name: "T-shirt L", description: "T-shirt taille L floqué YUL 2025", unit_price: 10.0, category: "Vestimentaire", event: event_1, emoji: "🎽"),
  Option.create!(name: "Perruque", description: "N'en prenez pas si vous avez conservé celle de l'an dernier", unit_price: 0, category: "Goodies", event: event_1, emoji: "🎀"),
  Option.create!(name: "Mug", description: "Au plus près de l'asso dès 7h du mat !", unit_price: 8, category: "Goodies", event: event_1, emoji: "☕️"),
  Option.create!(name: "Yulette", description: "Un porte-clés très très personnalisé", unit_price: 5, category: "Goodies", event: event_1, emoji: "🔑")
]

# Assign options to tickets
tickets[0].options << options[0..8]
tickets[1].options << options[0..8]
tickets[2].options << options[0..8]


# Participants and Participations

i = 0

454.times do
  i += 1
  ticket = event_1.tickets[0..2].sample 
  participant = Participant.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    event_id: event_1.id # Lier le participant à l'évènement
  )

  participation = Participation.create!(
    participant: participant,
    ticket: ticket,
    status: "confirmed",
    total_amount: 0,
    payment_id: nil,
    bib_number: i,
    )

    random_number = [0, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4 ].sample.to_i 
    random_number.times do
      option = options.sample
      quantity = [1, 1, 1, 2, 2, 2, 3, 3].sample 

      Order.create!(
        participation: participation,
        quantity: quantity,
        option: option
      )
    end

  # Calcul du montant total en fonction des options sélectionnées
  options_amount = participation.orders.sum { |order| order.quantity * order.option.unit_price }

  # Mise à jour du montant total de la participation
  participation.total_amount = ticket.unit_price + options_amount

  # Sauvegarde de la participation avec le montant total mis à jour
  participation.save!
end

55.times do
  i += 1
  ticket = event_1.tickets[3] 

  participant = Participant.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    event_id: event_1.id 
  )

  participation = Participation.create!(
    participant: participant,
    ticket: ticket,
    status: "confirmed",
    total_amount: 0,
    payment_id: nil,
    bib_number: i,
    )

  participation.total_amount = ticket.unit_price 
  participation.save!
end

puts "Created #{Event.count} events, #{Ticket.count} tickets, #{Option.count} options, #{Participant.count} participants, #{Participation.count} participations and #{Order.count} orders."
