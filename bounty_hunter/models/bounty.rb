require('pg')
class Bounty
  attr_accessor :name, :species, :bounty_value, :last_known_location
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i
    @last_known_location = options['last_known_location']
  end

  def create() #save
    db = PG.connect({
      dbname: 'bounty',
      host: 'localhost'
      })
    sql = "
    INSERT INTO bounties (name, species, bounty_value, last_known_location)
    VALUES ($1, $2, $3, $4)
    RETURNING *
  "

  values = [@name, @species, @bounty_value, @last_known_location]
  db.prepare("create_bounty", sql)
  #what it's calling, what its calling against?
  @id = db.exec_prepared("create_bounty", values)[0]['id'].to_i
  db.close()
  end


  def self.all()
      db = PG.connect({
        dbname: 'bounty',
        host: 'localhost'
        })
      sql = "SELECT * FROM bounties"
      values = []
      db.prepare("all", sql)
      bounties = db.exec_prepared("all", values)
      db.close()

      bounties_as_objects = bounties.map { |bounty| Bounty.new(bounty)}
      return bounties_as_objects
    end

    def update
      db = PG.connect({
        dbname: 'bounty',
        host: 'localhost'
        })
        sql = "UPDATE bounties
        SET (name, species, bounty_value, last_known_location)
        = ($1, $2, $3, $4)
        WHERE id = $5
        "
        values = [@name, @species, @bounty_value, @last_known_location, @id]
        db.prepare("update", sql)
        db.exec_prepared("update", values)
        db.close
  end
end
