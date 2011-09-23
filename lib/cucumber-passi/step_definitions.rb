Dir.glob('step_definitions/*.rb') do |ruby_file|
  require ruby_file
end

World(Passi::Helpers)
