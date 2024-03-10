# frozen_string_literal: true

require 'porous/version'
require 'porous/application'

Dir.glob(File.join('{components,pages}', '**', '*.rb')).each do |relative_path|
  require File.expand_path("#{Dir.pwd}/#{relative_path}")
end

module Porous
  class Error < StandardError; end
end
