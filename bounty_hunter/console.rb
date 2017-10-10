require('pry')
require_relative('models/bounty.rb')

#Bounty.delete_all

bounty_1 = Bounty.new(
  {
    'name' => 'Tony',
    'species' => 'Portugese',
    'bounty_value' => '1',
    #bounty reduced due to bringing cookies
    'last_known_location' => 'Codeclan'
  }
)

bounty_2 = Bounty.new(
  {
    'name' => 'Darren',
    'species' => 'Nohair',
    'bounty_value' => '200000000',
    #previous employers reclaiming lost money
    'last_known_location' => 'Codeclan'
  }
)

binding.pry
nil
