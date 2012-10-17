class CreateClubPhotos < ActiveRecord::Migration
  def up
    create_table :club_photos do |t|
      t.references :dj_club
      t.attachment :photo
      t.timestamps
    end

    ClubPhoto.reset_column_information

    count = DjClub.count
    i = 1

    DjClub.all.each do |club|
      puts "Migrating photo of #{i} / #{count} => id #{club.id} "
      club_photo = ClubPhoto.new
      club_photo.dj_club = club
      club_photo.photo = club.photo1
      club_photo.save
      i = i + 1
    end
  end

  def down
    drop_table :club_photos
  end
end