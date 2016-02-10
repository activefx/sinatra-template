require './app'
require 'sinatra/activerecord/rake'

task :default => :help

# Import any rake tasks
Dir.glob('tasks/*.rake').each { |r| import r }

desc "Run specs"
task :spec do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = './spec/**/*_spec.rb'
  end
end

desc "Run IRB console with app environment"
task :console do
  puts "Loading development console..."
  system("pry -r ./config/boot.rb")
end

desc "Start the development environment"
task :start do
  exec("foreman start")
end
