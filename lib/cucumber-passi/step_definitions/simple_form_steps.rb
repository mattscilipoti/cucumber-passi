# Checks for in-line alert/error message
# Usage:
#   Then "Tag" should have an alert
Then /^"([^"]*)" should have an alert$/ do |field|
  field = find_field(field)
  # find the sibling span.error for the found input
  page.find("##{field[:id]} + span.error").should_not be_nil
end

