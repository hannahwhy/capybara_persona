require 'cucumber/rake/task'

namespace :cucumber do
  Cucumber::Rake::Task.new(:ok, 'Run features that should pass') do |t|
    t.fork = true
    t.profile = 'default'
  end

  Cucumber::Rake::Task.new(:wip, 'Run WIP features') do |t|
    t.fork = true
    t.profile = 'wip'
  end
end

task :default => 'cucumber:ok'
