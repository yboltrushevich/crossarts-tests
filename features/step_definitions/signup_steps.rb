Given /^I am not logged in$/ do
  visit "/"
end

When /^I sign up with valid data as artist$/ do
  # Click Register button
  find('div.welcome-wam a.button').click

  # Click Create Account button
  find('div#artist.option .button').click

  user = get_user(true)

  fill_in "user-email", :with => user["email"]
  fill_in "user-first-name", :with => user["firstName"]
  fill_in "user-last-name", :with => user["lastName"]
  fill_in "user-password", :with => user["password"]

  page.execute_script("$('.create').click();")

  sleep 3
  page.should have_css('div.registration-step-1 input#confirmation-token')
  find('.close').click
end

When /^I confirm user's registration$/ do
  visit "/admin/dashboard"
  click_link('Users')

  user = get_user

  loop do
    case user['role']
      when 'artist'
        user_row = page.find('tr.user', text: user['fullName']) rescue nil
      when 'artist_team'
        user_row = page.find('tr.user', text: user['firstName']) rescue nil
      when 'consumer'
        user_row = page.find('tr.user', text: user['fullName']) rescue nil
      else
        puts "#{user['role']} role isn't defined"
    end

    if user_row
      user_row.find('td.table-actions a', text: 'Confirm').click

      break
    else
      page.find("span.next a").click rescue (raise "User #{user['fullName']} not found")
    end
  end
end

When /^I sign up with valid data as artist team$/ do
  # Click Register button
  find('div.welcome-wam a.button').click

  # Click Create Account button
  find('div#artist.option .button').click
  sleep 2

  #Choose Artist Team option
  find("div.area.roles div.option[data-role='artist_team']").click

  user = get_user(true,'artist_team')
  sleep 2

  # Fill in mandatory fields
  fill_in "user-email", :with => user["email"]
  fill_in "user-first-name", :with => user["firstName"]
  fill_in "user-password", :with => user["password"]

  #Click Create
  page.execute_script("$('.create').click();")

  #Confirmation page
  sleep 4
  page.should have_css('div.registration-step-1 input#confirmation-token')
  find('.close').click
end

When /^admin confirms my registration$/ do
  step "I logged in as an admin"
  step "I confirm user's registration"
  step "I logout"
end

When /^I sign up with valid data as consumer$/ do
  #Click Register button
  find('div.welcome-wam a.button').click

  # Click Create Consumer button
  find('div#consumer.option .button').click

  user = get_user(true,'consumer')

  fill_in "user-email", :with => user["email"]
  fill_in "user-first-name", :with => user["firstName"]
  fill_in "user-last-name", :with => user["lastName"]
  fill_in "user-password", :with => user["password"]

  page.execute_script("$('.create').click();")

  sleep 3
  page.should have_css('div.registration-step-1 input#confirmation-token')
  find('.close').click
end

Then /^I can configure my profile$/ do
  #configure 1st step after confirmation
  #upload avatar
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  if path.match(/^D:\//)
    path.gsub!(/\//, "\\")
  end
  within(".upload-block-avatar") {attach_file "file", path}
  sleep 5
  page.execute_script("$('.modal-wizard.cropper-wizard .ok').click();")
  sleep 2
  # define occupation
  find('.upload-block-text input[data-occupation="true"]').set(Faker::Lorem.word)
  # about me
  find('.upload-block-text textarea').set(Faker::Lorem.word)
  page.execute_script("$('.ok').click();")

  #configure 2nd step after confirmation
  find(".profile-category-input").set("name_1")
  all("ul.dropdown-menu li.active a").first.click
  page.execute_script("$('.ok').click();")

  #configure 3rd step after confirmation
  page.execute_script("$('.ok').click();")
end

