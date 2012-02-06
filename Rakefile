require 'bundler/gem_tasks'

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/*_spec.rb"
end

task :default => :test

# yanked from cucumber-rails
unless ARGV.any? {|a| a =~ /^gems/} # Don't load anything when running the gems:* tasks
  vendored_cucumber_bin = nil
#  vendored_cucumber_bin = Dir["#{Rails.root}/vendor/{gems,plugins}/cucumber*/bin/cucumber"].first
#  $LOAD_PATH.unshift(File.dirname(vendored_cucumber_bin) + '/../lib') unless vendored_cucumber_bin.nil?

  begin
    require 'cucumber/rake/task'
    namespace :cucumber do
      Cucumber::Rake::Task.new({:html_report => 'db:test:prepare'}, 'Run features that should pass and output report formatted as html') do |t|
        t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
        t.fork = true # You may get faster startup if you set this to false
        t.profile = 'html_report'
      end

      Cucumber::Rake::Task.new({:ok => 'db:test:prepare'}, 'Run features that should pass and output report formatted as html') do |t|
        t.binary = vendored_cucumber_bin # If nil, the gem's binary is used.
        t.fork = true # You may get faster startup if you set this to false
        t.profile = 'default'
      end
    end

    desc 'Alias for cucumber:ok'
    task :cucumber => 'cucumber:ok'

    task :default => :cucumber

    # In case we don't have ActiveRecord, append a no-op task that we can depend upon.
    task 'db:test:prepare' do
    end

  rescue LoadError
    desc 'cucumber rake task not available (cucumber not installed)'
    task :cucumber do
      abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
    end
  end
end
