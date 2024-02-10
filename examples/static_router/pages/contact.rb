class Contact < Porous::Page
  def self.route; ['contact']; end

  render :html do
    render Layout do
      ul do
        li { a(href: '/') { 'Home' } }
        li { a(href: '/about') { 'About' } }
        li { 'Contact' }
      end
    end
  end
end
