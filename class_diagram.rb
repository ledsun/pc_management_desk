model_name = ARGV[0]
class_name = Object.const_get model_name
puts '@startuml'
puts "class #{class_name} {"

class_name.columns.each do |c|
  printf "  %8s %s\n", c.type, c.name
end

class_name.public_instance_methods(false).each do |m|
  method_parameters = class_name.new.method(m)
                                .parameters
                                .filter{ |a| a[0] == :req }
                                .map { |a| a[1]}.join(', ')
  printf "  %s(%s)\n", m.to_s, method_parameters
end

puts '}'

class_name.reflect_on_all_associations(:belongs_to).each do |a|
  puts "#{class_name} --* #{a.name.to_s.classify}"
end
class_name.reflect_on_all_associations(:has_many).each do |a|
  puts "#{class_name} *-- #{a.name.to_s.classify}"
end
class_name.reflect_on_all_associations(:has_one).each do |a|
  puts "#{class_name} -- #{a.name.to_s.classify}"
end

puts '@enduml'
