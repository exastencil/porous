# frozen_string_literal: true

# Porous Core
require 'porous'

# Serve static files
require 'porous/extension/static'

# Server-side rendering
run Porous::Application.new
