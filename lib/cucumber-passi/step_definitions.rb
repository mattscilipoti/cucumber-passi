current_dir = File.expand_path(File.dirname(__FILE__))

#World(ActionController::RecordIdentifier) #for dom_id

Dir.glob(File.join(current_dir, 'support/*.rb')) do |ruby_file|
  puts "req: #{ruby_file}"
  require ruby_file
end

Dir.glob(File.join(current_dir, 'step_definitions/*.rb')) do |ruby_file|
  puts "req2: #{ruby_file}"
  require ruby_file
end
