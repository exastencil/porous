require 'thor'

begin
  require 'bundler'
  Bundler.require
rescue Bundler::GemfileNotFound
  require 'opal-virtual-dom'
end

require 'rack'
require 'rackup/server'

require 'porous/cli/build'
require 'porous/cli/new'
require 'porous/cli/server'
