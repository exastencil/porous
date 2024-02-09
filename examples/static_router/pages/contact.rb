class Contact < Porous::Page
  def self.route; ['contact']; end

  def html
    '<h1>Porous Web Engine</h1><ul><li>Contact</li><li><a href="/">Home</a></li><li><a href="/about">About</a></li>'
  end
end
