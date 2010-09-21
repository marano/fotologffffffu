@@user = 'lunks'
get '/' do
  fotolog = Fotolog.new(@@user)
  #@photos = fotolog.years.collect { |year| (1..12).collect { |month| fotolog.photos_for_month year, month } }
  #@photos.each do |each_photo|
    
  #end
  @photos = fotolog.years.map { |year| (1..12).map { |month| fotolog.photos_for_month year, month}}.flatten
  haml :index
end

