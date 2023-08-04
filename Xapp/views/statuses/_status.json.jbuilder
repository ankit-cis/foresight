json.extract! status, :id, :name, :description, :status_constant, :created_at, :updated_at
json.url status_url(status, format: :json)
