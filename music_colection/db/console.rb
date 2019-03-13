require('pry')
require_relative('../models/artists.rb')
require_relative('../models/albums.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({ 'name' => 'Prince'})
artist1.save_artist()

artist2 = Artist.new({'name' => 'Mateusz Stanczak'})
artist2.save_artist()

album1 = Album.new({
  'name' => 'Purple Rain',
  'genre' => 'Rock/Pop',
  'artist_id' => artist1.id
})
album1.save_album()

album2 = Album.new({
  'name' => 'Lovesexy',
  'genre' => 'Rock',
  'artist_id' => artist1.id
})
album2.save_album()

album3 = Album.new({
  'name' => 'Perfect Tonight',
  'genre' => 'Pop',
  'artist_id' => artist2.id
})
album3.save_album()

p Artist.all

p Album.all

p Artist.find(artist1.id)

p artist2.album

p album1.artist

artist1.name = 'Robyn'
artist1.update_artist
updated_artist = Artist.find(artist1.id)
p updated_artist.name

artist1.delete_artist
deleted_artist = Artist.find(artist1.id)



binding.pry
nil
