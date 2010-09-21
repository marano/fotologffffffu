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
  
  def photos_for_month year, month
    doc = Nokogiri::HTML(open("http://www.fotolog.com.br/#{@user}/archive?year=#{year}&month=#{month}"))
    doc.css('.imageContainer img').map do |photo|
      photo.attributes['src'].value.gsub('_t', '_f')
    end
  end
end
