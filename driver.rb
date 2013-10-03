require_relative 'app/models/representative'
require 'active_record'

joe = Politician.find 1
joe.update_column(:state, 'MA')
joe
Politician.all

p Politician.where(state: 'MA')

p Politician.column_names[0].class
