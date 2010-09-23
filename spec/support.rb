class CacheStub
  def initialize
    @map = {}
  end
  def set(key, value)
    @map[key] = value
  end
  def get(key)
    @map[key]
  end 
end

