puts "------- creating Tickets ------------------"
  10.times do
    Ticket.create!(
      name: "Course 10km",
      description: "sportifs c'est parti",
      unit_price: 12,
      event_id:Event.last.id
    )
  end
puts "-------#{Ticket.count} Tickets --------"
