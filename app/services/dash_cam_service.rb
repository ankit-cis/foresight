# app/services/dash_cam_service.rb
require 'net/http'
require 'uri'
require 'fileutils'

class DashCamService
  DASH_CAM_BASE_URL = "http://10.99.77.1" # Dash cam IP or hostname
  SERVER_UPLOAD_PATH = Rails.root.join('public', 'uploads', 'dash_cam_videos') # Path on server to store the videos

  # Retrieve a list of files from the dash cam
  def self.retrieve_file_list
    url = URI.parse("#{DASH_CAM_BASE_URL}/blackvue_vod.cgi")
    response = Net::HTTP.get_response(url)

    if response.is_a?(Net::HTTPSuccess)
      files = response.body.split("\n").map do |line|
        line.strip!
        next unless line.start_with?("n:") && line.include?(".mp4")
        file_path = line[/n:(.*?),s:/, 1]
        "#{DASH_CAM_BASE_URL}/#{file_path}" # Full URL to the video file
      end.compact
      files
    else
      puts "Error retrieving file list: #{response.message}"
      []
    end
  end

  # Download the video file from the dash cam and save it to the server
  def self.download_and_store_video(file_url)
    filename = File.basename(file_url)
    file_path_on_server = SERVER_UPLOAD_PATH.join(filename)

    # Skip if the file already exists on the server
    return if File.exist?(file_path_on_server)

    # Download the video file from the dash cam
    uri = URI.parse(file_url)
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      # Save the file to the server
      FileUtils.mkdir_p(SERVER_UPLOAD_PATH) unless Dir.exist?(SERVER_UPLOAD_PATH) # Ensure the directory exists
      File.open(file_path_on_server, 'wb') do |file|
        file.write(response.body)
      end

      puts "Downloaded and saved video: #{filename}"

      # Create a DashCamVideo record in the database with the local file path
      DashCamVideo.create!(
        file_name: filename,
        file_path: "/uploads/dash_cam_videos/#{filename}", # Relative path for serving
        uploaded_at: Time.current
      )

      puts "Stored video in database: #{filename}"
    else
      puts "Failed to download video: #{filename}, error: #{response.message}"
    end
  end

  # Sync new videos from the dash cam to the server
  def self.sync_new_videos
    files = retrieve_file_list
    files.each do |file_url|
      download_and_store_video(file_url)
    end
  end
end
