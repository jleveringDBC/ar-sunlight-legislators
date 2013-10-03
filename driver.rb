require_relative 'app/models/politician'
require 'active_record'

def state_politicians(state)

  puts "Senators:"
  Politician.where(state: state, senator: true).each do |poli|
    print poli.name; print "(#{poli.party})"
    puts ""
  end
  puts ""
  puts "Representatives"
  Politician.where(state: state, rep: true).each do |poli|
    print poli.name; print "(#{poli.party})"
    puts ""
  end

end

def gender_percentage(gender)
  if gender == :male
    gender_abbr  = "M"
  else
    gender_abbr  = "F"
  end
  sen_count = Politician.where(senator: true, gender: gender_abbr, active: true).count.to_f
  rep_count = Politician.where(rep: true, gender: gender_abbr, active: true).count.to_f
  sen_total = Politician.where(senator: true, active: true).count
  rep_total = Politician.where(rep: true, active: true).count
  if gender_abbr == 'M'
    puts "Male Senators: #{sen_count.to_i} (#{(sen_count/sen_total)*100}%)"
    puts "Male Representatives: #{rep_count.to_i} (#{(rep_count/rep_total)*100}%)"
  else
    puts "Female Senators: #{sen_count.to_i} (#{(sen_count/sen_total)*100}%)"
    puts "Female Representatives: #{rep_count.to_i} (#{(rep_count/rep_total)*100}%)"
  end
end

def polis_by_state
  rep_results = {}
  sen_reults = {}
  results = {}
  Politician.where(active: true).each do |poli|
    if results[poli.state]
      results[poli.state] << poli
    else
      results[poli.state] = [poli]
    end
  end
  #   if poli.rep && rep_results[poli.state]
  #     rep_results[poli.state] += 1
  #   elsif poli.rep
  #     rep_results[poli.state] = 1
  #   elsif poli.sen && sen_results[poli.state]
  #     sen_results[poli.state] += 1
  #   elsif poli.sen
  #     sen_results[poli.state] = 1
  #   end
  # end

  results = results.sort_by{|k,v| v.size}.reverse
  results.each do |key, value|
    sen, rep = 0, 0
    value.each do |poli|
      if poli.rep
        rep += 1
      else
        sen +=1
      end
    end
    puts "#{key}: #{sen} Senators, #{rep} Representative(s)"
  end
end

def poli_totals
  puts Politician.where(senator: true).count
  puts Politician.where(rep: true).count
end

def delete_inactives
  Politician.destroy_all(:active => false)
end

state_politicians('IL')
puts ""
gender_percentage(:male)
puts ""
polis_by_state
puts ""
poli_totals
puts ""
delete_inactives
poli_totals
