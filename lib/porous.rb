# frozen_string_literal: true

require 'porous/version'

# Extensions
require 'porous/extension'

# The Render Pipeline
require 'porous/render_context'
require 'porous/component'
require 'porous/preamble'
require 'porous/page'

# The Web Server
require 'porous/router'
require 'porous/application'

module Porous
  class Error < StandardError; end
end
