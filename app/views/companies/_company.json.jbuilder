json.extract! company, :id, :name, :company_type_id, :address_1, :address_2, :town, :county, :postcode, :telephone_number, :payment_type_id, :app_licenses, :created_at, :updated_at
json.url company_url(company, format: :json)
