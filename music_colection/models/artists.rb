require('pry')
require_relative('../db/sql_runner.rb')
require_relative('./albums.rb')

class Artist
  attr_reader :id
  attr_accessor :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def album
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    album_hashes = SqlRunner.run(sql, values)
    return album_hashes.map { |album_hash| Album.new(album_hash) }
  end

  def save_artist()
    sql = "INSERT INTO artists (name)
    VALUES ($1)
    RETURNING *"
    values = [@name]
    @id = SqlRunner.run(sql, values).first['id'].to_i
  end

  def update_artist
    sql = "UPDATE artists SET name = $1 WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete_artist
    sql = 'DELETE FROM artists WHERE id = $1'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM artists"
    artist_hashes = SqlRunner.run(sql)
    artists = artist_hashes.map { |hash| Artist.new(hash) }
    return artists
  end

  def self.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values).first
    return Artist.new(result) if result != nil
  end

  def self.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end
end
