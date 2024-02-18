# 🧽 Porous

Porous is a web engine that uses isomorphic Ruby components to build a Progressive Web App. Its use is analogous to a web framework, but the approach is entirely different. You write *only* the code that is *unique to your application* and the engine takes care of the rest!

This project is a **work-in-progress** and is not yet even in the Proof of Concept phase. However, if you are interested in a full-stack, everything included solution, that only requires you to use one language (that is arguably easy and enjoyable to write) then feel free to follow this project.

The closest thing to this I could find was [Volt](https://github.com/voltrb/volt) or [Silica](https://github.com/youchan/silica), neither of which are active or match the overall development flow I'm looking for.

## Current Features

- 🙅 No bundled runtime (only code unique to your app needs to be in your repository)
- 🖥️ Server-side rendering (server responds with the entire initial page populated for SEO)
- 💻 Client-side rendering (application bundle is served and interactions and subsequent pages are rendered client-side)
- 🌄 Serves static files (from `static` folder)
- 🔥 Hot reloading (via HTTP polling and browser refresh)

## Design

Applications are composed of `Page`s which are in turn composed of `Component`s. Data is persisted as `Entity`s in configurable store options (memory, disk, database). Client-server communication occurs as `Event`s over WebSockets.

### Page

A page is conceptually similar to what would be rendered when visiting a specific URL. So `www.example.com/blog/45` might render a `Blog` page, while `www.example.com/login` might render a `Login` page. Generally, code contained in pages are not reused.

### Components

A component is any composable unit of code responsible for rendering markup, potentially based on some state. This is somewhat equivalent to Web Components, in that it can also have some behaviour attached. But it can also simply be used to remove code duplication. Essentially any markup that has behaviour attached or would otherwise create code duplication should probably be in Components.

### Entities

Data in a Porous application is stored as entities. An `Entity` is a agglomeration of virtual attributes constructed from `Datom`s – pieces of information we know to be true about that entity at a point in time. In this way, full history of an entity is automatically maintained. `Datom`s are immutable, allowing for simpler synchronisation between client and server.

### Events

Every user maintains one open channel (WebSocket) to the server which can be used to send and receive `Event`s. This is the sole communication mechanism and is used for "database queries", push notifications, presence, analytics, etc.

## Installation

Porous is not a framework. You don't build an application with it as a dependency, you run it with your application configuration as input. As such you can easily install the gem globally to use it:

    $ gem install porous

## Usage

Porous is still pre-alpha and so is not ready for usage yet, but the general idea is that you would define your application's entities, pages, components and events in Ruby scripts structured in a specific way. Then you would simply run `porous` while pointing it to that folder and it will spin up a Rack-compatible web server for you to use.

> ⚠️ Expect any and all APIs to change radically until version 1.0! Hence why it won't be documented or properly tested until things settle to a more stable state.

To start a new Porous project simply `gem install porous` using whichever Ruby environment you want to use (Ruby 3.0+). Then change to that directory and run:

    $ porous server

By default Porous will run at `localhost:9292`. Now you can edit `pages/home.rb` or add more pages. Files you modify will be hot-reloaded so you can simply open the page in your browser and edit the file. Hot-reloading will be improved once WebSockets support is implemented.

### Running examples

To test out some example "apps" using Porous you can navigate to the examples folder and in any folder run:

    $ porous server

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/exastencil/porous. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/exastencil/porous/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Porous project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/exastencil/porous/blob/master/CODE_OF_CONDUCT.md).

## Acknowledgements

I'd like to thank Michał Kalbarczyk ([fazibear](https://github.com/fazibear)) for his work done on [Inesita](https://github.com/inesita-rb/inesita) and his [VirtualDOM wrapper](https://github.com/fazibear/opal-virtual-dom) which served as the starting point for my implementation of Porous. While my final approach may deviate significantly from theirs, having code to review and a workable starting point was invaluable.
