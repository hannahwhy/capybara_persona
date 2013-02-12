require File.expand_path('../../../features/support/browserid', __FILE__)

namespace :servers do
  namespace :browserid do
    desc 'Start the BrowserID platform'
    task :start do
      exec("cd #{BrowserID::ROOT} && exec node scripts/run_locally.js")
    end
  end
end
