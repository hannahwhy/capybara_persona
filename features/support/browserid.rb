require 'fileutils'

module BrowserID
  include FileUtils

  AUTHDB_FILE = File.expand_path('../authdb.json', __FILE__)
  ROOT = File.expand_path('../browserid', __FILE__)
  URL = 'http://127.0.0.1:10002'

  def setup_browserid_authdb
    cp AUTHDB_FILE, "#{ROOT}/var"
  end

  def wait_for_browserid
    threshold = 45

    status = (1..threshold).each do |i|
      cmd = "curl -s #{URL}"
      puts "Attempt #{i}/#{threshold}: #{cmd}"
      `#{cmd}`

      break :started if $?.success?
      sleep 1
    end

    if status != :started
      raise 'Unable to contact Persona'
    end
  end
end
