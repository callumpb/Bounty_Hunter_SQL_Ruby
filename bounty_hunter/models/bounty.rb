require('pg')

  class Bounty
    attr_accessor :name, :species, :bounty_value, :last_known_location
  #attr_reader on id because generally don't want to allow changes to id
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
      RETURNING id
    "
    #RETURNING * => what I had before

    values = [@name, @species, @bounty_value, @last_known_location]
    db.prepare("create_bounty", sql)
    #what it's calling, what its calling against?

    #@id = db.exec_prepared("create_bounty", values)[0]['id'].to_i
    #was what I had below

    array_of_hashes = db.exec_prepared("create_bounty", values)
    first_item_hash = array_of_hashes[0] #.first
    @id = first_item_hash["id"].to_i

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

      def self.find(id)
        db = PG.connect({
          dbname: 'bounty',
          host: 'localhost'
          })
        sql = "SELECT * FROM bounties
          WHERE id = $1"
        values = [id]
        db.prepare("find", sql)
        bounties = db.exec_prepared("find", values)
        bounty_hash = bounties[0] #bounties is the results array
        bounty = Bounty.new(bounty_hash)
        db.close()
        return bounty

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

      def delete
        db = PG.connect({
          dbname: 'bounty',
          host: 'localhost'
          })
          sql = "DELETE FROM bounties WHERE id = $1"
          values = [@id]
          db.prepare("delete", sql)
          db.exec_prepared("delete", values)
          db.close
      end

      def self.delete_all()
        db = PG.connect({
          dbname: 'bounty',
          host: 'localhost'
          })
          sql = "DELETE FROM bounties"
          values = []
          db.prepare("delete_all", sql)
          db.exec_prepared("delete_all", values)
          db.close
      end

end
