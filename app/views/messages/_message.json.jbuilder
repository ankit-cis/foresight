json.extract! message, :id, :company_id, :title, :body, :content, :expires, :created_at, :updated_at
json.url message_url(message, format: :json)
