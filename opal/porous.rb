# frozen_string_literal: true

require 'opal'
require 'native'
require 'promise'
require 'browser/setup/full'

require 'js'
require 'console'

require 'virtual_dom'
require 'virtual_dom/support/browser'

# Patch VirtualDOM to support SVG tags
module VirtualDOM
  module DOM
    SVG_TAGS = %w[animate animateMotion animateTransform circle clipPath defs desc ellipse filter foreignObject g image
                  line linearGradient marker mask metadata mpath path pattern polygon polyline radialGradient rect set
                  stop svg switch symbol textPath tspan use view].freeze
    SVG_TAGS.each do |tag|
      define_method tag do |params = {}, &block|
        if params.is_a?(String)
          process_tag(tag, {}, block, params)
        elsif params.is_a?(Hash)
          process_tag(tag, params, block)
        end
      end
    end
  end
end

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
  Browser::Socket.new '/connect' do
    on :open do |_e|
      $console.info 'Connected to server!'
    end

    on :message do |e|
      channel, content = e.data.split '|'
      case channel
      when 'build'
        if content == 'started'
          $console.log 'New build started…'
        else
          $console.log 'Reloading scripts…'
          $document.location.reload
        end
      else
        $console.log "Received #{e.data}"
      end
    end
  end
end
