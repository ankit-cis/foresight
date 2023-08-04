json.extract! my_profile, :id, :created_at, :updated_at
json.url my_profile_url(my_profile, format: :json)
