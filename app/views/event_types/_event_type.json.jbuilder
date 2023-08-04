json.extract! event_type, :id, :name, :event_type_const, :description, :created_at, :updated_at
json.url event_type_url(event_type, format: :json)
