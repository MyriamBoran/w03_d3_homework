require('pry')
require_relative('../models/artists.rb')
require_relative('../models/albums.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({ 'name' => 'Prince'})
artist1.save()

artist2 = Artist.new({'name' => 'Mateusz Stanczak'})
artist2.save()

album1 = Album.new({
  'name' => 'Purple Rain',
  'genre' => 'Rock/Pop',
  'artist_id' => artist1.id})
album1.save()

album2 = Album.new({
  'name' => 'Lovesexy',
  'genre' => 'Rock',
  'artist_id' => artist1.id})
album2.save()

album3 = Album.new({
  'name' => 'Perfect Tonight',
  'genre' => 'Pop',
  'artist_id' => artist2.id})
album3.save()
# p album1

# found = Album.find('Perfect Tonight')
# p found
# p Album.find(album2)

artist1[:name] = 'Biorg'


binding.pry()
nil
