json.extract! accident, :id, :user_id, :company_id, :lat, :long, :video_id, :accident_status_id, :created_at, :updated_at
json.url accident_url(accident, format: :json)
