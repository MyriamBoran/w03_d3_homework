require_relative('../db/sql_runner.rb')
require_relative('./artists.rb')

class Album
  attr_reader :id, :artist_id
  attr_accessor :name, :genre
  def initialize(options)
    @name = options['name']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def artist
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [@artist_id]
    artists_hashes = SqlRunner.run(sql, values).first
    return Artist.new(artists_hashes)
  end

  def save()
    sql = "INSERT INTO albums (name, genre, artist_id)
    VALUES ($1, $2, $3)
    RETURNING id"
    values = [@name, @genre, @artist_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM albums"
    album_hashes = SqlRunner.run(sql)
    albums = album_hashes.map { |hash| Album.new(hash)  }
    return albums
  end

  def self.find(album)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [album.id]
    result = SqlRunner.run(sql, values).first

    # if found.ntuples == 0
    #   return nil
    # end
    #
    return Album.new(result)
  end

end
