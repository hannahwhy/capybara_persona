require File.expand_path('../../../features/support/browserid', __FILE__)

namespace :servers do
  namespace :browserid do
    desc 'Start the BrowserID platform'
    task :start do
      Dir.chdir(BrowserID::ROOT) do
        exec('node', './scripts/run_locally.js')
      end
    end
  end
end
