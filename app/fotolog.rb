class Fotolog

  attr_accessor :user

  def initialize user=nil
    @user = user
  end

  def valid?
    not Net::HTTP.get_response(URI.parse(archive_url)).is_a? Net::HTTPNotFound
  end

  def year_archive_url year
    "http://www.fotolog.com.br/#{@user}/archive?year=#{year}&month=1"
  end

  def years
    Nokogiri::HTML(open(archive_url)).css('#years').text.scan(/\d{4}+/)
  end

  def archive_url
    "http://www.fotolog.com/#{@user}/archive"
  end

  def photos
    years.map { |year| (1..12).map { |month| photos_for_month year, month}}.flatten
  end

  def photos_for_month year, month
    doc = Nokogiri::HTML(open("http://www.fotolog.com.br/#{@user}/archive?year=#{year}&month=#{'0' if month.to_i < 10}#{month.to_i}"))
    doc.css('.imageContainer img').map do |photo|
      full_image_for photo.attributes['src'].value
    end
  end

def add_to_cache
  cache.set(@user, photos) if cache.get(@user).nil?
  add_user_to_cache
end

def add_user_to_cache
  unless recent_users.include? @user
    recent_users_list = recent_users
    recent_users_list.push @user
    cache.set 'recent_users', recent_users_list
  end
end

def cache
  Cache.instance
end
def recent_users
  if cache.get('recent_users').nil?
    cache.set 'recent_users', []
  end
  cache.get 'recent_users'
end

def retrieve_photos
  valid? or return
  add_to_cache
  cache.get @user
end

  def full_image_for photo
    addr = ''
    splited = photo.split('_t')
    splited.each_index do |index|
      if index == splited.size - 1
        addr = "#{addr}_f#{splited[index]}"
      else
        if index == 0
          addr = splited[index]
        else
          addr = "#{addr}_t#{splited[index]}"
        end
      end
    end
    return addr
  end
end

