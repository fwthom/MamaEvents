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
  description: "Passer un moment convivial de sport avec la marche ou la course, mais également de fête (musique, tombola et barbecue pour clôturer la journée).",
  date: Date.new(2025, 10, 05),
  charity: charity,
  status: "brouillon"

)


event_2 = Event.create!(
  name: "La MAMA 2026",
  description: "Passer un moment convivial de sport entre mère et fille avec la mama 2025.",
  date: Date.new(2026, 5, 5),
  charity: charity,
  status: "brouillon"

)


# Create tickets for the event (both presentiel and distanciel)
Ticket.create!(
  name: "Marche 5km",
  description: "Une marche détendue de 5 km",
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
  name: "Course 10km (distanciel)",
  description: "Une petite course non chronométrée, à faire chez soi !",
  unit_price: 7.0,
  event: event_1
)

tickets = Ticket.all

# Options
options = [
  Option.create!(name: "Frites", description: "Délicieuses et croustillantes, à la graisse de bœuf", emoji: "🍟", unit_price: 4.0, category: "Alimentaire", event: event_1),
  Option.create!(name: "Hot Dog", description: "Un délicieux hot dog", unit_price: 5.0, category: "Alimentaire", emoji: "🌭", event: event_1),
  Option.create!(name: "T-shirt S", description: "T-shirt taille S floqué YUL 2025", unit_price: 10.0, category: "Vestimentaire", event: event_1, emoji: "🎽"),
  Option.create!(name: "T-shirt M", description: "T-shirt taille S floqué YUL 2025", unit_price: 10.0, category: "Vestimentaire", event: event_1, emoji: "🎽"),
  Option.create!(name: "T-shirt L", description: "T-shirt taille S floqué YUL 2025", unit_price: 10.0, category: "Vestimentaire", event: event_1, emoji: "🎽"),
  Option.create!(name: "Perruque", description: "Obligatoire pour l'évènement, à cocher si vous n'en avez-pas !", unit_price: 0, category: "Goodies", event: event_1, emoji: "🎀")
]

# Assign options to tickets
tickets[0].options << options[0..5]
tickets[1].options << options[0..5]
tickets[2].options << options[0..5]

# Participants and Participations
50.times do
  event = event_1 # Assurez-vous que `event_1` est défini et est un objet valide.
  ticket = event.tickets[0..1].sample # Assurez-vous qu'il y a bien des tickets dans l'événement.

  array = [0, 1, 1, 2, 2, 2]
  random_number = array.sample.to_i # Nombre aléatoire de commandes à créer

  participant = Participant.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    event_id: event.id # Lier le participant à l'événement
  )

  participation = Participation.create!(
    participant: participant,
    ticket: ticket,
    status: "confirmed",
    total_amount: ticket.unit_price, # Le montant initial est le prix du ticket
    payment_id: nil # Remplacer par un `payment_id` valide si nécessaire
  )

  # Création des commandes associées à la participation
  random_number.times do
    # Assurez-vous que `options` est un tableau contenant des options valides
    option = options.sample # Option aléatoire
    quantity = [1, 1, 1, 2].sample # Quantité aléatoire pour chaque option

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

puts "Created #{Event.count} events, #{Ticket.count} tickets, #{Option.count} options, #{Participant.count} participants, #{Participation.count} participations and #{Order.count} orders."
