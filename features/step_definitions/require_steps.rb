When /^I require "([^"]*)"$/ do |file|
  require File.expand_path("#{file}", 'lib')
end

Then /^these libraries should be loaded:$/ do |table|
  actual = table.rows_hash.keys.collect do |key|
    passi_module = key.gsub('Passi::','')
    [key, Passi.const_defined?(passi_module).to_s]
  end
  table.diff! actual
end

