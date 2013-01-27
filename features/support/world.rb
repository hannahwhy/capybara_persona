class TestWorld
  def within_persona_window
    within_window(persona_window) { yield }
  end

  def persona_window
    @persona_window ||= begin
                          handles = page.driver.browser.window_handles

                          handles.detect do |h|
                            within_window(h) do
                              page.has_xpath?('//title', :text => /Persona/)
                            end
                          end
                        end
  end

  def reset_persona_window
    @persona_window = nil
  end
end

World do
  TestWorld.new 
end
