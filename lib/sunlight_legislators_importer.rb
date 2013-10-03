require 'csv'
require 'active_record'
require_relative '../app/models/politician'

class SunlightLegislatorsImporter
  def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      poli_args = Hash.new
      row.each do |field, value|
        case field
        when "twitter_id"
          poli_args[:twitter] = value if value != ""
        when "in_office"
          if value == "0"
            poli_args[:active] = false
          else
            poli_args[:active] = true
          end
        when "title"
          if value == "Rep"
            poli_args[:rep] = true
            poli_args[:senator] = false
          elsif value == "Sen"
            poli_args[:rep] = false
            poli_args[:senator] = true
          end
        else 
          if !Politician.column_names.include?(field)
          next
        end
          poli_args[field.to_sym] = value if value != ""
        end
      end
      if poli_args[:rep] || poli_args[:senator]
          new_poli = Politician.create(poli_args)
          # p new_poli.errors
        else
          p row
          p poli_args
          p "not a rep or senator"#raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
        end
    end
  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
begin
  raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
  SunlightLegislatorsImporter.import(ARGV[0])
rescue ArgumentError => e
  $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
rescue NotImplementedError => e
  $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
end
