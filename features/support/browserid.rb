require 'stringio'

BROWSERID_ROOT = File.expand_path('../browserid', __FILE__)

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

def start_browserid
  Dir.chdir(BROWSERID_ROOT) do
    sio = StringIO.new
    $pid = Process.spawn('node', './scripts/run_locally.js', { :out=>"/dev/null" })
    puts "BrowserID daemon starting as PID #{$pid}"

    ok = (1..30).each do |i|
      cmd = "curl -s http://127.0.0.1:10002"
      puts "Attempt #{i}/30: #{cmd}"
      `#{cmd}`

      break true if $?.success?
      sleep 1
    end

    if !ok
      abort 'BrowserID platform failed to start'
    end
  end
end

def stop_browserid
  if $pid
    Process.kill('INT', $pid)
    Process.wait($pid)
  end
end

AfterConfiguration do
  verify_prerequisites
  start_browserid
  sleep 3
end

at_exit do
  stop_browserid
end
