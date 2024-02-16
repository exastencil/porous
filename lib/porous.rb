# frozen_string_literal: true

require 'opal'
require 'opal-browser'
Opal.append_path File.expand_path('../opal', __dir__)

require 'opal-virtual-dom'
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

require 'porous/server'

module Porous
end
