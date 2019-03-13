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
    artist_hash = SqlRunner.run(sql, values).first
    return Artist.new(artist_hash)
  end

  def save()
    sql = "INSERT INTO albums (name, genre, artist_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@name, @genre, @artist_id]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update
    sql = "UPDATE albums SET (name, genre, artist_id) = ($1, $2, $3) WHERE id = $4"
    values = [@name, @genre, @artist_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = 'DELETE FROM albums WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM albums"
    album_hash = SqlRunner.run(sql)
    album = album_hash.map { |hash| Album.new(hash)  }
    return album
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Album.new(result)
  end

  def self.delete_all
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end
end
