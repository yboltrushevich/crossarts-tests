Given /^I am on Login page$/ do
  visit "/users/login"
end

When /^I login with credentials:$/ do |table|
  table.rows_hash.each { |field, value| fill_in field, :with => value }
  find('.btn').click
end

Then /^I should be redirected to User Timeline page$/ do
  page.should have_css("body.user-timeline_events-index")
  screen_shot_and_save_page
end

Given /^I logged in with "(.*?)" and "(.*?)"$/ do |email, password|
  step "I am on Login page"
  step "I login with credentials:", table(%{
    | user_email | #{email}       |
	  | user_password | #{password} |
  })
  step "I should be redirected to User Timeline page"
end

Given /^I logged in as an admin$/ do
  step %{I logged in with "admin@example.com" and "secret"}
end

Given /^I can login as a user$/ do
  user = get_user
  step %{I logged in with "#{user['email']}" and "#{user['password']}"}
end

When /^I logout$/ do
  page.find('.user-more').click
  page.find('.user-logout').click
  sleep 2
end
