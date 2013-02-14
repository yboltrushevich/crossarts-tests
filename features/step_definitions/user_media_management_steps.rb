When /^I create set$/ do
  wait_and_click("Media")
  wait_and_click("Add Media")

  # Wizard Step 1: Define set title
  @title = Faker::Company.bs
  page.find(:css, "div.wizard-step-1 input.name").set @title
  wait_and_click("Continue")

  # Wizard Step 2: Upload artwork
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  within(".files-uploader-step") { attach_file "file", path }
  sleep 10 # waiting for artwork uploading
  wait_and_click("Continue")

  # Wizard Step 3: Choose categories
  all(".modal-wizard div.category").first.click
  wait_and_click("Continue")

  # Wizard Step 4: Remain access type by default and Publish
  wait_and_click("Publish")
end

Then /^I see set details page$/ do
  page.should have_content("Set was successfully created")
  page.should have_content(@title)
end