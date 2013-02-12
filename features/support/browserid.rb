require 'fileutils'
require 'stringio'
require 'tmpdir'

BROWSERID_ROOT = File.expand_path('../browserid', __FILE__)

include FileUtils

$artifact_dir = ENV['ARTIFACT_DIR'] || Dir.mktmpdir
$log_file = "#{$artifact_dir}/browserid.log"
puts "Writing BrowserID log to #{$log_file}"

def assert_shell_ok(command, message)
  `#{command}`

  if !$?.success?
    abort message
  end
end

def verify_prerequisites
  # Do we have npm in $PATH?
  assert_shell_ok('which npm', 'npm not found')

  # Is the submodule present?
  assert_shell_ok("cd #{BROWSERID_ROOT} && ls -1 .git", 'submodule not checked out')
end

def setup_browserid_authdb
  cp File.expand_path('../authdb.json', __FILE__), "#{BROWSERID_ROOT}/var"
end

def start_browserid
  Dir.chdir(BROWSERID_ROOT) do
    $pid = Process.spawn('node', './scripts/run_locally.js', { :out=>$log_file })
    puts "BrowserID daemon starting as PID #{$pid}"

    threshold = 45

    status = (1..threshold).each do |i|
      cmd = "curl -s http://127.0.0.1:10002"
      puts "Attempt #{i}/45: #{cmd}"
      `#{cmd}`

      break :started if $?.success?
      sleep 1
    end

    if status != :started
      abort 'BrowserID platform failed to start'
    end
  end
end

def stop_browserid
  if $pid
    Process.kill('INT', $pid)

    begin
      Process.wait($pid)
    rescue Errno::ECHILD
      # must have died before we got to wait, oh well
    end
  end
end

AfterConfiguration do
  verify_prerequisites
  setup_browserid_authdb
  start_browserid
  sleep 3
end

at_exit do
  stop_browserid
end
