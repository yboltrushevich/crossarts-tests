Given /^I am on Login page$/ do
  visit "/users/login"
end

Then /^I should be redirected to Home page$/ do
  page.should have_css("body.pages-index.signed-in")
  sleep 5
  screen_shot_and_save_page
end

Given /^I logged in with "(.*?)" and "(.*?)"$/ do |email, password|
  step "I am on Login page"
  find('input#user-email').set(email)
  find('input#user-password').set(password)
  page.execute_script("$('button.ok').click()")
end

Given /^I logged in as an admin$/ do
  step %{I logged in with "admin@example.com" and "secret"}
  step "I should be redirected to Home page"
end

Given /^I can login as a user$/ do
  user = get_user
  step %{I logged in with "#{user['email']}" and "#{user['password']}"}
  sleep 2
  page.should have_css("div.modal-wizard.edit-profile")
end

When /^I logout$/ do
  #page.find('.user-more').click
  page.execute_script("$('.user-more').click();")

  #page.find('.user-logout').click
  page.execute_script("$('.user-logout').click();")
  sleep 2
end
