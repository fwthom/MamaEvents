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
Charity.destroy_all

User.create!(
  email: "jean@lewagon.org",
  password: "password" # Rails prendra soin de générer l'encrypted_password
)

Charity.create!(
  name: "Mes Amis Mes Amours",
  description: "An organization dedicated to providing aid to those in need.",
  contact_email: "contact@helpinghands.org",
  phone_number: "+1234567890",
  # user_id: User.first.id
)