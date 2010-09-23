class Cache
  def self.open
    Dalli::Client.new('localhost:11211')
  end
end

