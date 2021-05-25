model_name = ARGV[0]
class_name = Object.const_get model_name
puts '@startuml'
puts "class #{class_name} {"

class_name.columns.each do |c|
  printf "  %8s %s\n", c.type, c.name
end

class_name.public_instance_methods(false).each do |m|
  printf "  %s(%s)\n", m.to_s, class_name.new.method(m).parameters.filter{ |a| a[0] == :req }.map { |a| a[1]}.join(', ')
end

puts '}'
puts '@enduml'
