module DomHelpers
  def wait_and_click(link_or_button, seconds=1)
    sleep seconds
    click_link_or_button(link_or_button)
  rescue Selenium::WebDriver::Error::MoveTargetOutOfBoundsError
    page.execute_script(%{
      var link = $("a:contains('#{link_or_button}'), button:contains('#{link_or_button}'), input[type='submit'][value='#{link_or_button}']");
      link.click();
    })
  end
end

World(DomHelpers)