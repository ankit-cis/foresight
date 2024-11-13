class DashCamVideo < ApplicationRecord
    mount_uploader :video, DashCamVideoUploader
end
