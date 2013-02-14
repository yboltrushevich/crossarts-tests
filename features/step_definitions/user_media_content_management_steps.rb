Given /^I am on the "(.*?)" page$/ do |page_title|
	click_link(page_title)
end

Given /^I completed all steps of wizard$/ do
	step "I completed the first step of wizard"
	step "I completed the second step of wizard"
end

Then /^I should be redirected to View Set page$/ do
	
end

Given /^I completed the first step of wizard$/ do
	title = Faker::Company.bs
	page.find(:css, "div.wizard-step-1 input.name").set title
	click_button("Continue")
end

Given /^I completed the second step of wizard$/ do
	path = File.expand_path(File.dirname(__FILE__) + "/../media_content/image1.jpg" )
	locator = find(:css, "div.wizard-step-uploader input[name='file']")
	attach_file locator, path
	click_button("Continue")
end
