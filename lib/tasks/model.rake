namespace :model do
  task :annotate, [:name] => [:environment] do |_, args|
    Object.const_get(args[:name].capitalize).columns.each do |c|
      printf "%20s %10s \n", c.name, c.type
    end
  end
end
