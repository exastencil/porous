# Bundler Setup
require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require

# Serve static files
require 'rack/static'

# Server-side rendering
run Porous::Application.new
