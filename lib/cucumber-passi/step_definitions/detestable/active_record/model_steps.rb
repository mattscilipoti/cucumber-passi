# Depends: factory_girl (for rails 2.x),
#          factory_girl_rails (for rails 3.x)
begin
  require 'factory_girl'
rescue LoadError => need_factory_girl
    $stderr.puts <<-EOS
#{'*'*50}
  Could not find the 'factory_girl' gem.
  This is required for active_record related steps.
  If you did not intend to use these steps, please specify the libraries you wish to use.

  Otherwise:
      gem install factory_girl #(for rails 2.x),
  OR
      gem install factory_girl_rails #(for rails 3.x)

#{'*'*50}
  EOS
  exit(1)
end

module Passi::StepHelpers

  # Converts a "model name" to a factory name
  # Email #=> :emai l
  # Projects #=> :project
  def to_factory_name(requested_model)
    requested_model.singularize.underscore.to_sym
  end

  # Maps each model to a unique_identifier column for that model/table
  # Examples:
  #    :project => :title,
  #    :email => :subject
  #
  # TODO: move to declaration
  def human_readable_identifier_columns
    { :project => :title }
  end
end

World(Passi::StepHelpers)

# Single-line step scoper
# When /^(.*) for (.*[^:])$/ do |step, parent|

#   with_scope(parent) { When step }
# end


# Example:
#   Given 5 Emails exist
#
Given /^(\d+) ([^ ]+)(?: exist[s]?)?$/i do |count, requested_model|
  factory_name = to_factory_name(requested_model)

  count.to_i.times do
    Factory.create(factory_name)
  end
end

# Example:
#   Given these Projects exist:
#     | title | start_date | end_date |
#
Given /^these ([^ ]+)(?: exist)?:$/ do |requested_model, table|
  factory_name = to_factory_name(requested_model)

  table.hashes.each do |model_attributes|
    generate_model(factory_name, model_attributes)
  end
end

# Generates the given model, using FactoryGirl
# Example:
#   Given Project:TestABC [exists]
#
Given /^([^ ]+) "([^"]+)" exists$/ do |requested_model, unique_identifer|
  factory_name = to_factory_name(requested_model)

  Factory.create(factory_name,
                 human_readable_identifier_columns[factory_name.to_sym] => unique_identifer)
end

# Generates a model instance with the passed attributes
# Supports some associations, see generate_model.
#
# Example:
#   Given Project:TestABC exists with:
#     | title | start_date | end_date |
Given /^([^ ]+) "([^"]+)" exists with:$/ do |requested_model, unique_identifer, table|
  factory_name = to_factory_name(requested_model)
  unique_identifier_column = human_readable_identifier_columns[factory_name.to_sym]
  model_attributes = { unique_identifier_column => unique_identifer }.merge(table.hashes.first)
  generate_model(factory_name,  model_attributes)
end

# Finds or creates parent model and generates children with passed attributes
# Example:
#   Given Project "Foo" has these Users:
#     | last_name |
Given /^([^ ]+) "([^"]+)" has these (.+):$/ do |requested_model, unique_identifier, requested_association, table|
  parent_model_class = requested_model.parameterize.classify.constantize
  unique_identifier_column = human_readable_identifier_columns[parent_model_class.name.underscore.to_sym]
  parent_model = parent_model_class.first(:conditions => {unique_identifier_column => unique_identifier}) || generate_model(to_factory_name(requested_model), unique_identifier_column => unique_identifier)

  association = requested_association.parameterize.underscore
  table.hashes.each do |model_params|
    parent_model.send(association).create(model_params)
  end
end

# WARN: these are NOT testing what the user sees.
Then /^I should find these (.+):$/i do |requested_model, table|
  junk, requested_model_name, scope = Array(requested_model.match(/(\w+)[(]?(\w*)/))

  scope = :all if scope.blank?
  model_class = requested_model_name.classify.constantize
  if model_class == Email
    table.map_columns! {|value| ERB::Util.html_escape(value)}
  end
  found_models = model_class.send(scope).map{|email| email.attributes.stringify_values }
  table.diff! found_models
end
