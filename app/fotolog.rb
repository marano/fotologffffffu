require 'httpclient'
class Fotolog

  attr_accessor :user

  def initialize user=nil
    @user = user
    @client = HTTPClient.new
  end

  def valid?
    @client.get(archive_url, follow_redirect: true).status == 200
  end

  def year_archive_url year
    "http://www.fotolog.com.br/#{@user}/archive/1/#{year}/"
  end

  def years
    Nokogiri::HTML(@client.get_content(archive_url)).css('#list_years_calendar').text.scan(/\d{4}+/)
  end

  def archive_url
    "http://www.fotolog.com.br/#{@user}/archive/"
  end

  def photos
    years.map { |year| (1..12).map { |month| photos_for_month year, month}}.flatten
  end

  def photos_for_month year, month
    doc = Nokogiri::HTML(@client.get_content("http://www.fotolog.com.br/#{@user}/archive/#{'0' if month.to_i < 10}#{month.to_i}/#{year}"))
    doc.css('.calendar_month_day img').map do |photo|
      full_image_for photo.attributes['src'].value
    end
  end

  def add_to_cache
    cache.set(@user, photos) if Array(cache.get(@user)).empty?
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
    if Array(cache.get('recent_users')).empty?
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

  def update_cache
    last_cached_photo = cache.get(@user).last
    last_archive_photo = last_photo
    if (last_cached_photo == last_archive_photo)
      return false
    end
    new_photos = cache.get(@user) << last_archive_photo
    cache.set @user, new_photos
  end

  def last_photo
    doc = Nokogiri::HTML(@client.get_content("http://www.fotolog.com/#{@user}/archive/"))
    full_image_for doc.css(".wall_img_container img")[0].attributes['src'].value
  end
end

