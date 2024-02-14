# frozen_string_literal: true

require 'opal'
require 'opal-browser'
Opal.append_path File.expand_path('../../opal', __FILE__)

require 'opal-virtual-dom'
require 'listen'

require 'porous/version'
require 'porous/server'

module Porous
end
