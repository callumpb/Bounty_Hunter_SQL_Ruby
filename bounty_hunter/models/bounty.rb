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

  def create()
    db = PG.connect({
      dbname: 'bounties',
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

end
