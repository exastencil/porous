class Home < Porous::Page
  render :html do
    h1 { 'Porous Web Engine' }

    ul do
      li { 'Home' }
      li { a(href: '/about') { 'About' } }
      li { a(href: '/contact') { 'Contact' } }
      li { a(href: '/missing') { "This page doesn't exist" } }
    end
  end
end
