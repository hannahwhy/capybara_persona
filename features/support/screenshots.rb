require 'shellwords'

if ENV['CAPTURE_DIR']
  Before do
    @step_counter = 0
    mkdir_p ENV['CAPTURE_DIR']
  end

  AfterStep do |scenario|
    cdir = ENV['CAPTURE_DIR']
    fn = Shellwords.escape("#{cdir}/#{scenario.title}-#{@step_counter}.png")
    `import -window root #{fn}`
  end
end
