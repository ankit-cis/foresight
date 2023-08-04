# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env.development?
  puts "*************************************************"
  puts "**       Running in Development Mode...        **"
  puts "*************************************************"
elsif Rails.env.test?
  puts "*************************************************"
  puts "**          Running in Test Mode...            **"
  puts "*************************************************"
elsif Rails.env.production?
  puts "*************************************************"
  puts "**       Running in Production Mode...         **"
  puts "*************************************************"
else
  puts "*************************************************"
  puts "**      Running in an unknown mode?            **"
  puts "*************************************************"
end

require File.expand_path('../seeds/titles', __FILE__)
require File.expand_path('../seeds/company_types', __FILE__)
require File.expand_path('../seeds/payment_types', __FILE__)

require File.expand_path('../seeds/statuses', __FILE__)

david = User.create(email: "david@pinchtozoom.co.uk", password: "ptzoom123", password_confirmation: "ptzoom123", is_admin: false, 
                    forename: "David", surname: "Hopkinson", title: Title.first, address: "1 Toy Town Avenue, Warrington, Cheshire, WA0",
                    insurer: "Great Insurance Inc.", telephone_number: "07515 748514")

User.create(email: "admin@ptzoom.co.uk", password: "ptzoom123", password_confirmation: "ptzoom123", is_admin: true, forename: "Admin", surname: "Account")

pinch = Company.create( name: "Pinch to Zoom", subdomain: "pinch-to-zoom", company_type: CompanyType.first, 
                        address_1: "Cinnamon House, Cinnamon Park",
                        address_2: "Crab Lane",
                        town: "Warrington",
                        county: "Cheshire",
                        postcode: "WA2 0XP",
                        telephone_number: "01925 661848",
                        payment_type: PaymentType.first,
                        forename: "David", 
                        surname: "Hopkinson",
                        email: "david@pinchtozoom.co.uk",
                        app_licenses: 10)

CompanyUser.create(company_id: pinch.id, user_id: david.id, is_company_admin: true, is_app_user: true)

david.company = pinch
david.save!