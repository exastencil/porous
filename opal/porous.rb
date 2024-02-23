# frozen_string_literal: true

require 'opal'
require 'native'
require 'promise'
require 'browser/setup/full'

require 'js'
require 'console'

require 'virtual_dom'
require 'virtual_dom/support/browser'

require 'porous/injection'
require 'porous/component/class_methods'
require 'porous/component/render'
require 'porous/component/virtual'
require 'porous/component'
require 'porous/page'

require 'porous/routes'
require 'porous/router'
require 'porous/application'

module Porous
  class Error < StandardError; end
  class InvalidRouteError < Error; end
end

$document.ready do
  Porous::Application.mount_to($document.body)
  Browser::Socket.new $connection do
    on :open do |_e|
      $console.info 'Connected to server!'
    end

    on :message do |e|
      channel, content = e.data.split '|'
      case channel
      when 'build'
        $document.location.reload unless content == 'started'
      else
        $console.log e.data
      end
    end
  end
end
