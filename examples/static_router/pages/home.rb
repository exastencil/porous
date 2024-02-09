class Home < Porous::Page
  def self.route; []; end

  def html
    '<h1>Porous Web Engine</h1><ul><li>Home</li><li><a href="/about">About</a></li><li><a href="/contact">Contact</a></li>'
  end
end
