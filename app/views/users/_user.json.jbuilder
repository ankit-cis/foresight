json.extract! user, :id, :email, :password_digest, :forename, :surname, :title_id, :address_1, :address_2, :town, :county, :postcode, :insurer, :telephone_number, :is_admin, :created_at, :updated_at
json.url user_url(user, format: :json)
