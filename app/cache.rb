class Cache
  def self.instance
    @@cache ||= Dalli::Client.new('localhost:11211')
  end
end

