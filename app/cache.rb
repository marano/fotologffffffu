class Cache
  def self.instance
    Dalli::Client.new('localhost:11211')
  end
end

