class Home < Porous::Page
  render :html do
    render Layout do
      ul do
        li { 'Home' }
        li { a(href: '/about') { 'About' } }
        li { a(href: '/contact') { 'Contact' } }
      end
    end
  end
end
