When /^I create set$/ do
  #Click Library
  find('.library').click

  sleep 3
  #Click Add Set
  all('div#media-header.profile-header .button').first.click

  # Wizard Step 1: Define set title
  set_title = Faker::Company.bs
  page.find(:css, "div.wizard-step-1 input.name").set set_title
  page.execute_script("$('.ok').click();")

  # Wizard Step 2: Upload artwork
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  sleep 3
  #attach_file ".files-uploader-step input[name='file']", path
  within(".files-uploader-step") do
	  attach_file "file", path
  end
  page.has_selector?(".file-controls .thumbnail img")
  page.execute_script("$('.ok').click();")

  # Wizard Step 3: Choose categories
  all(".modal-wizard div.category").first.click
  page.execute_script("$('.ok').click();")

  # Wizard Step 4: Remain access type by default and Publish
  page.execute_script("$('.ok').click();")
end

Then /^I see set details page$/ do
  page.should have_css(".flash-message")
  page.should have_css('.content_sets-show')
end

When /^I create presentation$/ do
  #Click Library
  find('.library').click

  #Click Add Presentation
  new_url = current_url + '/presentations/new'
  visit new_url

  # Define presentation title, privacy settings, categories, status
  @presentation_title = Faker::Company.bs
  fill_in "presentation_title", :with => @presentation_title
  find('div#presentation_visibility_chzn.chzn-container a.chzn-single').click
  find('ul.chzn-results li', text:'Everyone').click

  find(".category-input").set("name_67")
  all("ul.dropdown-menu li.active a").first.click

  # Upload presentation cover
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  within(".item-fields-with-poster") { attach_file "file", path}
  sleep 5
  page.execute_script("$('.ok').click();")
  sleep 2

  #Add widget
  click_link("Add Content Item")
  within(".upload-tab-content"){attach_file "file", path}

  # BUG with categories
  click_link("Create Presentation")

  #Create presentation via preview mode
=begin
  click_link('Preview')
  sleep 2
  all('a.preview-save-button').first.click
=end
  #BUG redirect on SHOWCASE -> now presentation on media
end

Then /^I see presentation details page$/ do
  page.should have_content(@presentation_title)
end

When /^I had at least one media set in personal library$/ do
  pending
end

When /^I create set with existing items from media library$/ do
  pending
end