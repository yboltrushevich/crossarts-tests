Given /^I am on Home page$/ do
  visit "/"
end

Given /^I click on "(.*?)"$/ do |elem|
  wait_time
=begin
  case elem
    when "Sign Up"
      click_link(elem)
    when  "Create your Domain"
      click_button(elem)
    when "Create Account"
	    page.execute_script("$('.create').click();")
    else
      raise
  end
=end
  if elem == "Create Account"
    page.execute_script("$('.create').click();")
  else
    click_link_or_button(elem)
  end
end

When /^I agree with terms$/ do
  wait_time
  click_button("Ok")
end

When /^I fill in all mandatory fields$/ do
  user = get_user
	wait_time
    fill_in "user-email", :with => user["email"]
    fill_in "user-first-name", :with => user["firstName"]
    fill_in "user-last-name", :with => user["lastName"]
    fill_in "user-password", :with => user["password"]
end

Then /^I should be redirected on Confirmation page$/ do
  wait_time
  page.should have_css('body.confirmations-new')
end

When /^I confirm user's registration$/ do
  click_link('Admin::Dashboard')
  click_link('Users')

  user = get_user

  loop do
    user_row = page.find('tr.user', text: user['fullName']) rescue nil

    if user_row
      user_row.find('td.table-actions a', text: 'Confirm').click

      break
    else
      page.find("span.next a").click rescue (raise "User #{user['fullName']} not found")
    end
  end
end