require 'erb'
require 'yaml'
require 'active_record'

# dotenv-rails gemを使っていたら環境変数を読み込む
begin
  require 'dotenv/load'
rescue LoadError
  # 何もしない
end

ActiveRecord::Base.establish_connection YAML.load(ERB.new(File.read('config/database.yml')).result)['development']

model_name = ARGV[0]
class_name= Object.const_set model_name, Class.new(ActiveRecord::Base)
puts '@startuml'
puts "class #{class_name} {"
class_name.columns.each do |c|
  printf "  %8s %s\n", c.type, c.name
end
puts '}'
puts '@enduml'