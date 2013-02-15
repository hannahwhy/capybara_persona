require 'shellwords'

if ENV['CAPTURE_DIR']
  Before do
    mkdir_p ENV['CAPTURE_DIR']
  end

  AfterStep do |scenario|
    cdir = ENV['CAPTURE_DIR']
    now = Time.now.to_f
    fn = Shellwords.escape("#{cdir}/#{scenario.title}-#{now}.png")
    `import -window root #{fn}`
  end
end
