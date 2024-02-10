class About < Porous::Page
  def self.route; ['about']; end

  render :html do
    h1 { 'Porous Web Engine' }

    ul do
      li { a(href: '/') { 'Home' } }
      li { 'About' }
      li { a(href: '/contact') { 'Contact' } }
    end
  end
end
