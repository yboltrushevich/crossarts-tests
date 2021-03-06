When /^I create set$/ do
  #Click Library
  find('.library').click

  sleep 5
  #Click Add Set
  all('div.actions-block .button')[1].click

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

Then /^I see set details page$/ do
  page.should have_css(".flash-message")
  page.should have_css('.content_sets-show')
  page.should have_content(@set_title)
  page.should have_content(@filename)
end

When /^I create presentation$/ do
  #Click Library
  find('.library').click

  #Click Add Presentation
  new_url = current_url + '/presentations/new'
  visit new_url

  # Define presentation title, privacy settings, categories, status
  @presentation_title = Faker::Lorem.word
  fill_in "presentation_title", :with => @presentation_title
  find('div#presentation_visibility_chzn.chzn-container a.chzn-single').click
  
  #Doesn't work for Russian localization
  #find('ul.chzn-results li', text:'Everyone').click
  all('ul.chzn-results li').first.click
  
  find(".category-input").set("name_67")
  all("ul.dropdown-menu li.active a").first.click

  # Upload presentation cover
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  if path.match(/^D:\//)
      path.gsub!(/\//, "\\")
  end
  @filename = 'image1'
  
  within(".item-fields-with-poster") { attach_file "file", path}
  sleep 5
  page.execute_script("$('.ok').click();")
  sleep 2

  #Add widget
  click_link("add-widget-content_item")
  within(".upload-tab-content"){attach_file "file", path}

  # BUG with categories name_1
  #Doesn't work for Rus locale
  #click_link("Create Presentation")
  find('a.done-button.preview-save-button').click
  sleep 5
end

Then /^I see presentation details page$/ do
  page.should have_content(@presentation_title)
end

When /^I have at least one media set in personal library$/ do
  step "I create set"
end

When /^I create set with existing items from media library$/ do
  #Switch to All tab
  sleep 3
  all('.nav-links a').first.click

  sleep 5
  #Click Add Set
  all('div.actions-block .button')[1].click

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
  all(".item-container .content-item img").first.click
  sleep 2
  page.execute_script("$('.ok').click();")
  @filename = 'crap'

  # Wizard Step 3: Choose categories
  all(".modal-wizard div.category").first.click
  page.execute_script("$('.ok').click();")

  # Wizard Step 4: Remain access type by default and Publish
  page.execute_script("$('.ok').click();")
end

When /^I upload media to existing set$/ do
  #Switch to All tab
  sleep 3
  all('.nav-links a').first.click
  sleep 5

  #Find created set in library
  sets = all('.content-set h4.item-title')
  sets.each{ |set|
    if set.text == @set_title
      set.click
      break
    end
  }
  sleep 2

  #Click Add Artworks
  find('a.button').click

  # Upload artwork
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  if path.match(/^D:\//)
      path.gsub!(/\//, "\\")
  end
  sleep 3
  @filename = 'image1'
  
  within(".files-uploader-step") do
    attach_file "file", path
  end
  page.has_selector?(".file-controls .thumbnail img")
  page.execute_script("$('.ok').click();")
end

Then /^I see created set with selected items$/ do
  page.should have_css('.content_sets-show')
  page.should have_content(@set_title)
  page.should have_css(".item-container .content-item img[src='"+@file_url+"']")
end

Then /^I see uploaded media in selected set$/ do
  page.should have_css('.content_sets-show')
  page.should have_content(@filename)
end

When /^I change set data$/ do
  #Switch to All tab
  sleep 3
  all('.nav-links a').first.click
  sleep 5

  #Find created set in library
  sets = all('.content-set h4.item-title')
  sets.each{ |set|
    if set.text == @set_title
      set.click
      break
    end
  }
  sleep 2
  
  #Click Preferences icon
  find('div.nav-popup.settings a.nav-item').click
  #Click Edit link
  all('ul.nav-menu[data-media-settings="data-media-settings"] a')[0].click
  
  # Define new set title
  @new_set_title = Faker::Lorem.word
  fill_in "content_set_title", :with => @new_set_title

  #Define new set description
  @new_set_description = Faker::Lorem.word
  fill_in "content_set_description", :with => @new_set_description
  
  #Add a new category
  find(".category-input").set("name_30")
  all("ul.dropdown-menu li.active a").first.click
  
  #Change set type
  find('div#content_set_professional_art_piece_chzn.chzn-container a.chzn-single').click
  find('.chzn-results li#content_set_professional_art_piece_chzn_o_1.active-result').click
  
  #Change set visibility settings
  find('div#content_set_visibility_chzn.chzn-container a.chzn-single').click
  find('ul.chzn-results li#content_set_visibility_chzn_o_3.active-result').click
  
  #Upload content item
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  if path.match(/^D:\//)
      path.gsub!(/\//, "\\")
  end
  @filename = 'image1'
  within(".uploader-box-multiple"){attach_file "file", path}
  
  #Click Done button
  page.execute_script("$('input.done-button').click();")
  sleep 3
end

Then /^I see updated set details$/ do
  page.should have_css('.content_sets-show')
  page.should have_content(@new_set_title)
  page.should have_content(@filename)
end

When /^I delete set$/ do
  #Switch to All tab
  sleep 3
  all('.nav-links a').first.click
	sleep 5
  
	sets = all('.content-set h4.item-title')
	sets.each{ |set|
		if set.text == @set_title
			set.click
			break
		end
	}
	sleep 2

  #Click Preferences icon
  find('div.nav-popup.settings a.nav-item').click
  #Click Delete link
  all('ul.nav-menu[data-media-settings="data-media-settings"] a')[1].click
	page.driver.browser.switch_to.alert.accept
	sleep 5
end

Then /^I see media library page without this set$/ do
	page.should have_css('.user-media-index')
	sets = all('.content-set h4.item-title')
	sets.each do |set|
		if set.text == @set_title
      raise "Set #{@set_title} hasn't been deleted"
    end
	end
end

When /^I copy the set to user showcase$/ do
  #Switch to All tab
  sleep 3
  all('.nav-links a').first.click
	sleep 5
  
	sets = all('.content-set h4.item-title')
	sets.each{ |set|
		if set.text == @set_title
			set.click
			break
		end
	}
	
	sleep 3
	#Click Preferences icon
	find('li.submenu-item a.edit-button-img').click
	#Click Copy to Showcase link
	page.execute_script("$('li.submenu-item a')[3].click()")
	sleep 2
end

Then /^I see the set on user showcase$/ do
	#Go to Showcase list
	find('.back-arrow').click

  page.should have_content(@set_title)
end

When /^I create presentation with existing items from media library$/ do
  #Switch to All tab
  sleep 3
  all('.nav-links a').first.click

  #Click Add Presentation
  new_url = current_url + '/presentations/new'
  visit new_url
  sleep 2

  # Define presentation title, privacy settings, categories, status
  @presentation_title = Faker::Lorem.word
  fill_in "presentation_title", :with => @presentation_title
  find('div#presentation_visibility_chzn.chzn-container a.chzn-single').click
  
  #Define presentation visibility
  all('ul.chzn-results li').first.click
  
  #Choose category
  find(".category-input").set("name_67")
  all("ul.dropdown-menu li.active a").first.click

  # Upload presentation cover
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  if path.match(/^D:\//)
      path.gsub!(/\//, "\\")
  end
  
  within(".item-fields-with-poster") { attach_file "file", path}
  sleep 5
  page.execute_script("$('.ok').click();")
  sleep 2

  #Add widget
  click_link("add-widget-content_item")
  #Select item from first media set
  #within(".upload-tab-content"){attach_file "file", path}
  find('.simple_form li.galleries-tab a').click
  sleep 3
  all('.simple_form .submission-content-set a').first.click
  sleep 5
  all('.simple_form .photo-item img.pic').first.click
  sleep 5
  
  find('a.done-button.preview-save-button').click
end

Given /^I have at least one presentation in personal library$/ do
  step 'I create presentation'
end

When /^I change presentation data$/ do
  #Click Edit button
  all('.links-right a').first.click

  # Define new presentation title
  @new_presentation_title = Faker::Lorem.word
  fill_in "presentation_title", :with => @new_presentation_title

  # Change visibility
  find('div#presentation_visibility_chzn.chzn-container a.chzn-single').click
  find('ul.chzn-results li#presentation_visibility_chzn_o_3').click

  # Change status
  find('div#presentation_status_chzn a.chzn-single').click
  find('ul.chzn-results li#presentation_status_chzn_o_2').click

  # Add new category
  find(".category-input").set("name_3")
  all("ul.dropdown-menu li.active a").first.click

  #Add CI widget
  click_link("add-widget-content_item")
  path = File.expand_path(File.dirname(__FILE__) + "/../fixtures/image1.jpg" )
  if path.match(/^D:\//)
    path.gsub!(/\//, "\\")
  end
  within(".upload-tab-content"){attach_file "file", path}

  #Add title widget
  click_link("add-widget-title")
  @title_widget = Faker::Lorem.word
  find('#widget_content_attributes_body').set(@title_widget)

  #Click Update button
  find('a.done-button.preview-save-button').click
end

Then /^I see updated presentation details$/ do
  page.should have_css('.presentations-show')
  page.should have_content(@new_presentation_title)
  page.should have_content(@title_widget)
end

When /^I delete presentation$/ do
  #Click Delete presentation
  find('div.links-right a[data-method="delete"]').click
  page.driver.browser.switch_to.alert.accept
end

Then /^I see media library page without this presentation$/ do
  page.should have_css('.user-media-index')
  presentations = all('.presentation h4.item-title')
  presentations.each do |presentation|
    if presentation.text == @presentation_title
      raise "Presentation #{@presentation_title} hasn't been deleted"
    end
  end
end

When /^I copy the presentation to user showcase$/ do
  #Click the Copy to Showcase link
  find('div.links-right a[data-method="post"]').click

end

Then /^I see the presentation on user showcase$/ do
  #Go to Showcase list
  page.execute_script("$('div.links-right a')[2].click();")

  page.should have_content(@presentation_title)
end