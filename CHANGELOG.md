## [Planned]

- Data Abstraction Layer / Object Relational Model
- Event Model
- Plugin / Extension system

- Frontend Extensions
  - Tailwind CSS (tailwind-cli)

- Persistence Extensions
  - Memory (default)
	- Disk (file)
	- Databases (SQLite, PostgreSQL)

## [Unreleased]

## [0.3.2] - 25 February 2024

- Serve static files with Agoo
- Split Porous JavaScripts from application scripts

## [0.3.1] - 24 February 2024

- Production Mode
	- `porous build production`
	- `porous server`
	- Needs `ssl/cert.pem` and `ssl/key.pem`
	- Binds on :80 and :443
- Development Mode
	- `porous dev`
	- Binds on :9292
- Serves favicon from `static/favicon.svg`

## [0.3.0] - 22 February 2024

- WebSockets support

## [0.2.0] - 18 February 2024

- Server-side hot reloading (browser reloads on changes)
- Dynamic page metadata (title and description)
- Less noisy logging (silence logging for Rack::Static)
- Client-side component rendering (sans SVG support)
- Client-side routing / navigation
- Client-side hot reloading

## [0.1.1] - 17 February 2024

- Server-side reloading (server requests reflect changes)

## [0.1.0] - 15 February 2024

- `porous server` to run apps
- Only server-side HTML rendering
- Component-based server-side routing
- No Entity support
- No Event support
- No persistence
- No client-side (transpiled) components
