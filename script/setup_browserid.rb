#!/usr/bin/env ruby

Dir.chdir(File.expand_path('../../features/support/browserid', __FILE__)) do
  `npm install`
end
