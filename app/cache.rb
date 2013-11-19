class Cache
  def self.instance
    Dalli::Client.new
  end
end

