class Fotolog

  def get_archive_url user
    "http://www.fotolog.com/#{user}/archive"
  end
  
  def get_years url
    doc = Nokogiri::HTML(open(url))
    years = doc.css('#years').text
    years.scan(/\d{4}+/)
  end
end
