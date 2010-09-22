class Fotolog

  def initialize user
    @user = user
  end
  
  def year_archive_url year
    "http://www.fotolog.com.br/#{@user}/archive?year=#{year}&month=1"
  end
  
  def years
    doc = Nokogiri::HTML(open(archive_url))
    years = doc.css('#years').text
    years.scan(/\d{4}+/)
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
      photo.attributes['src'].value.gsub('_t', '_f')
    end
  end
end
