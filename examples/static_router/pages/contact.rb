class Contact < Porous::Page
  def self.route; ['contact']; end

  render :html do
    h1 { 'Porous Web Engine' }

    ul do
      li { a(href: '/') { 'Home' } }
      li { a(href: '/about') { 'About' } }
      li { 'Contact' }
    end
  end
end
