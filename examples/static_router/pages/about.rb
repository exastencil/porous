class About < Porous::Page
  def self.route; ['about']; end

  render :html do
    render Layout do
      ul do
        li { a(href: '/') { 'Home' } }
        li { 'About' }
        li { a(href: '/contact') { 'Contact' } }
      end
    end
  end
end
