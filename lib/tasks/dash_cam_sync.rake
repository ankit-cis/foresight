# lib/tasks/dash_cam.rake
namespace :dash_cam do
    desc "Sync new videos from dash cam every 5 minutes"
    task sync_videos: :environment do
      DashCamService.sync_new_videos
      puts "Dash cam videos synchronized and saved to the database."
    end
  end
  
  