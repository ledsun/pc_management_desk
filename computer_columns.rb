require 'erb'
require 'yaml'
require 'active_record'

ActiveRecord::Base.establish_connection YAML.load(ERB.new(File.read('config/database.yml')).result)['development']
class Computer < ActiveRecord::Base; end
Computer.columns.each do |c|
  printf "%20s %10s \n", c.name, c.type
end
