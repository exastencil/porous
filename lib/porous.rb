# frozen_string_literal: true

require 'opal'
require 'opal-browser'
require 'opal-virtual-dom'

Opal.append_path File.expand_path('../opal', __dir__)
Opal.append_path File.expand_path(Dir.pwd)

require 'agoo'
require 'listen'

require 'porous/version'

require 'porous/injection'
require 'virtual_dom/virtual_node'
require 'virtual_dom/dom'
require 'porous/component/class_methods'
require 'porous/component/render'
require 'porous/component/virtual'
require 'porous/component'
require 'porous/page'
require 'porous/routes'
require 'porous/router'

Dir.glob(File.join('{components,pages}', '**', '*.rb')).each do |relative_path|
  require File.expand_path("#{Dir.pwd}/#{relative_path}")
end

require 'porous/application'
require 'porous/server' unless RUBY_ENGINE == 'opal'

module Porous
  class Error < StandardError; end
  class InvalidRouteError < Error; end
end
