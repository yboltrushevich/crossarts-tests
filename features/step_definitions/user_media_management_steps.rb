When /^I create set$/ do
  wait_and_click("Media")
  wait_and_click("Add Media")

  # Wizard Step 1: Define set title
  @set_title = Faker::Company.bs
  page.find(:css, "div.wizard-step-1 input.name").set @set_title
  wait_and_click("Continue")

  # Wizard Step 2: Upload artwork
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  sleep 3
  #attach_file ".files-uploader-step input[name='file']", path
  within(".files-uploader-step") do
	attach_file "file", path 
  end
  page.has_selector?(".file-controls .thumbnail img")
  wait_and_click("Continue")

  # Wizard Step 3: Choose categories
  all(".modal-wizard div.category").first.click
  wait_and_click("Continue")

  # Wizard Step 4: Remain access type by default and Publish
  wait_and_click("Publish")
end

Then /^I see set details page$/ do
  page.should have_content("Set was successfully created")
  page.should have_content(@set_title)
end

When /^I create presentation$/ do
  wait_and_click("Media")
  wait_and_click("Add Presentation")

  # Define presentation title, privacy settings, categories, status
  @presentation_title = Faker::Company.bs
  fill_in "project_title", :with => @presentation_title
  select "Everyone", :from => "project_visibility"
  fill_in(".category-input", :with => "name_1")
  within(".dropdown-menu") { select "name_1"}

  # Upload presentation cover
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  sleep 3
  #attach_file ".files-uploader-step input[name='file']", path
  within(".item-poster ") do
	attach_file "file", path 
  end
  sleep 2
  page.find(".modal-wizard button.ok").click

  # Add widget
  click_link("Add Content Item")
  within(".upload-tab-content"){attach_file "file", path}

  wait_and_click("Create Presentation")
end

Then /^I see presentation details page$/ do
	page.should have_content("Set was successfully created")
  page.should have_content(@presentation_title)
end