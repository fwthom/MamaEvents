puts "------- creating Tickets ------------------"
  10.times do
    Ticket.create!(
      name: "Course 10km",
      description: "Une course de 10 km",
      unit_price: 12.0,
      event_id:Event.last.id
    )
  end
puts "-------#{Ticket.count} Tickets --------"
