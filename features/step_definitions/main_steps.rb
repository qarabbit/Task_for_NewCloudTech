### GIVEN ###
Given /^I open website (.*?)$/ do |website|
  if website == 'hh.ru'
    visit_page "#{$config['server']}/"
  else
    visit_page website
  end
end

### WHEN ###
When /^I search company (.*?)$/ do |company|
  find(SEARCH_FIELD).set company
  find(SEARCH_BUTTON).click
end

When /^I open (.*?) company page$/ do |company|
  step "I search company #{company}"
  first(COMPANY_IN_VACANCY_DESCR, text: company).click
end

When /^I open vacancies for (current|other) region$/ do |region|
  css = region == 'current' ? CURRENT_REGION_VACANCY : OTHER_REGION_VACANCY
  first("#{css}").click
end

### THEN ###
Then /^I should see search result for (.*?)$/ do |name|
  expect(page).to have_css(VACANCY_TITLE, text: name)
end

Then /^I should see (\d+) vacancies for (current|other) regions?$/ do |expected_count, region|
  index = region == 'current' ? 0 : 1
  actual_count = all(VACANCY_COUNTER)[index].text
  expect(actual_count).to eq expected_count
end

Then /^I should see (.*?) vacancy$/ do |vacancy|
  expect(page).to have_css(VACANCY_IN_REGION_TITLE, text: vacancy)
end
