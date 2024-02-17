# frozen_string_literal: true

require 'opal'
require 'native'
require 'promise'
require 'browser/setup/full'

require 'js'
require 'console'

require 'virtual_dom'
require 'virtual_dom/support/browser'

VirtualDOM::DOM::HTML_TAGS = %w[a abbr address area article aside audio b base bdi bdo big blockquote body br
                                button canvas caption cite code col colgroup data datalist dd del details dfn
                                dialog div dl dt em embed fieldset figcaption figure footer form h1 h2 h3 h4 h5
                                h6 head header hr html i iframe img input ins kbd keygen label legend li link
                                main map mark menu menuitem meta meter nav noscript object ol optgroup option
                                output p param picture pre progress q rp rt ruby s samp script section select
                                small source span strong style sub summary sup table tbody td textarea tfoot th
                                thead time title tr track u ul var video wbr svg path].freeze

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
end
