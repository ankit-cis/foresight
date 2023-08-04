json.extract! video, :id, :user_id, :company_id, :lat, :long, :accident_id, :video_data, :created_at, :updated_at
json.url video_url(video, format: :json)
