module Passi::StepHelpers
  def find_label(value)
    page.all(:css, 'label').detect { |label| label.text == value }
  end

  def default_finder(model)
    if model == Email
      :find_by_subject
    else
      :find_by_title
    end
  end

  def requested_model_pattern
    %{([^"]+) "([^"]+)"}
  end
end

# Single-line step scoper
# Using [^:] in last group to support multi-line scoper
#
# Translates:
#   When I follow "Edit" for Project:A
# Into:
#   When I follow "Edit" within "#project_1"
# Usage:
#   When /^I follow "([^"]*)" for Project:ProjA$/ do |arg1|
#When /^I (follow|press) "([^"]+)" for #{requested_model_pattern}$/ do |action, field, model_name, record_identifier|
#  # TODO: convert requested_model_pattern into a Transform?
#  model = model_name.classify.constantize
#
#  mut = model.send(default_finder(model), record_identifier)
#  model_selector = '#' + dom_id(mut)
#  step %{I #{action} "#{field}" within "#{model_selector}"}
#end

# Checks for in-line alert/error message
# Usage:
#   Then "Tag" should have an alert
Then /^"([^"]*)" should have an alert$/ do |field|
  field = find_field(field)
  # find the sibling span.error for the found input
  page.find("##{field[:id]} + span.error").should_not be_nil
end

# Alias for 'Then I should be on'
Then /^I should be viewing (.+)$/ do |page_name|
  step %(I should be on #{page_name})
end

# Alias for 'Then I should be on the edit page for'
Then /^I should be editing (.+)$/ do |page_name|
  step %(I should be on the "edit" page for #{page_name})
end

Then /^I should see the following:$/ do |table|
  table.rows_hash.each do |field, value|
    label = find_label(field)
    raise "Could not find label '#{field}'" unless label
    element_id = label.native.attributes['for'].value
    step %(I should see "#{value}" within "##{element_id}")
    #page.should have_css("##{element_id}", value)
  end
end

Then /^I should not see any "([^"]*)" buttons$/ do |locator|
  expect{find(:xpath, XPath::HTML.link_or_button(locator))}.to raise_error(Capybara::ElementNotFound)
end

Then /^should not see any alert[s]?$/ do
  page.should have_no_css('.alert')
end

Then /^I should not see any notifications$/ do
  page.should have_no_css(".flash")
end

#EXPERIMENT: Toying with removing the ^I, so we can say I|we|they
Then /should not see any (notice|alert)[s]?$/ do |level|
  page.should have_no_css(".flash.#{level}")
end

Then /^I should see this alert "([^"]*)"$/ do |message|
  if message.blank?
    step 'I should not see any alerts'
  else
    step %{I should see "#{message}" within ".alert"}
  end
end

Then /^I should see this button "([^"]*)"$/ do |message|
  page.find_button(message)
end

Then /^I should see this notice "([^"]*)"$/ do |message|
  if message.blank?
    step 'I should not see any notices'
  else
    step %{I should see "#{message}" within ".notice"}
  end
end

Then /^"([^"]*)" should contain "([^"]*)"$/ do |requested_fieldset, value|
  fieldset_id = requested_fieldset.underscore
  within "fieldset##{fieldset_id}" do
    page.should have_css('span', value)
  end
end

When /^I click "([^"]*)"$/ do |locator|
  click_link_or_button(locator)
end

# Alias to 'When I am on'
# Sounds better for:
#    When I am viewing the emails for Project:A
When /^I am viewing (.+)$/ do |page_name|
  step %(I am on #{page_name})
end

Then /^I should( not)? see "([^"]*)" inside a dialog$/ do |negate, message|
  step %(I should#{negate} see "#{message}" within ".dialog")
end

Then /^I should not see(?: an| the)? "([^"]*)" link$/ do |message|
  page.should have_no_link(message)
end

Then /^the headline should (?:be|include) "([^"]*)"$/ do |headline|
  within 'h1' do
    if page.respond_to? :should
      page.should have_content(headline)
    else
      assert page.has_content?(headline)
    end
  end
end
