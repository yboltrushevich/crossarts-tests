Then /^I see showcase set details page$/ do
  page.should have_css(".flash-message")
  page.should have_css('.content_sets-show')
  page.should have_content(@set_title)
  page.should have_content(@filename)
end

When /^I create showcase set$/ do
  #Click Showcase
  find('.projects').click
  sleep 2

  #Click Add Set
  find('.profile-header-menu a.button.anchor').click
  page.execute_script("$('ul.sub-menu a')[0].click();")

  # Wizard Step 1: Define set title
  @set_title = Faker::Lorem.word
  page.find(:css, "div.wizard-step-1 input.name").set @set_title
  page.execute_script("$('.ok').click();")

  # Wizard Step 2: Upload artwork
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  if path.match(/^D:\//)
    path.gsub!(/\//, "\\")
  end
  @filename = 'image1'
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
  sleep 2
end

When /^I create showcase set with existing items from media library$/ do
  #Click Showcase
  find('.projects').click
  sleep 2

  #Click Add Set
  find('.profile-header-menu a.button.anchor').click
  page.execute_script("$('ul.sub-menu a')[0].click();")

  # Wizard Step 1: Define set title
  @set_title = Faker::Lorem.word
  page.find(:css, "div.wizard-step-1 input.name").set @set_title
  page.execute_script("$('.ok').click();")
  sleep 2

  # Wizard Step 2: Upload artwork
  #Click on [Select from Media Library] link
  all('.wizard-step-uploader .tabs-menu li[data-sets-link="true"] a').first.click
  sleep 2
  #Click the first set
  all(".content-set-album span img").first.click
  sleep 2
  #Click the first trumb
  @file_url = all(".content-set-album span img").first[:src]
  all('.item-container .content-item img[alt="Content Item"]').first.click
  sleep 2
  page.execute_script("$('.ok').click();")

  # Wizard Step 3: Choose categories
  all(".modal-wizard div.category").first.click
  page.execute_script("$('.ok').click();")

  # Wizard Step 4: Remain access type by default and Publish
  page.execute_script("$('.ok').click();")
end

Then /^I see created showcase set with selected items$/ do
  page.should have_css('.content_sets-show')
  page.should have_content(@set_title)
  page.should have_css(".item-container .content-item img[src='"+@file_url+"']")
end

Given /^I have at least one set in showcase$/ do
  step 'I create showcase set'
end

When /^I upload media to existing showcase set$/ do
  #Click Showcase
  find('.projects').click
  sleep 2

  #Open the first Set
  all('.content-set a').first.click

  #Click Add Artworks
  find('a.button').click

  # Upload artwork
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  @filename = 'image1'
  within(".files-uploader-step") do
    attach_file "file", path
  end
  page.has_selector?(".file-controls .thumbnail img")
  page.execute_script("$('.ok').click();")
end

Then /^I see uploaded media in selected showcase set$/ do
  page.should have_css('.content_sets-show')
  page.should have_content(@set_title)
  page.should have_content(@filename)
end