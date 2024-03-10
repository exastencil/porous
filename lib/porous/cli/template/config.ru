# Bundler Setup
require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require

# Load application-specific code
Dir.glob File.join(__dir__, '{components,pages}', '**', '*.rb'), &method(:require)

# Serve static files
require 'rack/static'

# Server-side rendering
run Porous::Application.new
