class About < Porous::Page
  def self.route; ['about']; end

  def html
    '<h1>Porous Web Engine</h1><ul><li>About</li><li><a href="/">Home</a></li><li><a href="/contact">Contact</a></li>'
  end
end
