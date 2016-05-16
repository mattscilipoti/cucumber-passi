Then /^I should not see any errors$/ do
  page.should_not have_css('#error_explanation')
  step 'I should not see any alerts'
end
