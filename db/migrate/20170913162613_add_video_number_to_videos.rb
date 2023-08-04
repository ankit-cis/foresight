class AddVideoNumberToVideos < ActiveRecord::Migration[5.1]
  def self.up
    add_column :videos, :video_number, :integer
    execute <<-SQL
         CREATE SEQUENCE video_number_seq START 1;
         ALTER SEQUENCE video_number_seq OWNED BY videos.video_number;
         ALTER TABLE videos ALTER COLUMN video_number SET DEFAULT nextval('video_number_seq');
        SQL
  end

  def self.down
    remove_column :videos, :video_number
    execute <<-SQL
      DROP SEQUENCE video_number_seq;
    SQL
  end
end
